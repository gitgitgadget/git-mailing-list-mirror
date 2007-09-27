From: Junio C Hamano <gitster@pobox.com>
Subject: Use of strbuf.buf when strbuf.len == 0
Date: Wed, 26 Sep 2007 23:21:24 -0700
Message-ID: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 08:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iamki-0003fk-IZ
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbXI0GVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbXI0GVa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:21:30 -0400
Received: from rune.pobox.com ([208.210.124.79]:58245 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801AbXI0GV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 02:21:29 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3D53213971B;
	Thu, 27 Sep 2007 02:21:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 895C71396E0;
	Thu, 27 Sep 2007 02:21:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59268>

I am starting to hate some parts of the strbuf API.

Here is an example.  Can you spot what goes wrong?

static int handle_file(const char *path,
	 unsigned char *sha1, const char *output)
{
	SHA_CTX ctx;
	char buf[1024];
	int hunk = 0, hunk_no = 0;
	struct strbuf one, two;
	...
	if (sha1)
		SHA1_Init(&ctx);

	strbuf_init(&one, 0);
	strbuf_init(&two,  0);
	while (fgets(buf, sizeof(buf), f)) {
		if (!prefixcmp(buf, "<<<<<<< "))
			hunk = 1;
		else if (!prefixcmp(buf, "======="))
			hunk = 2;
		else if (!prefixcmp(buf, ">>>>>>> ")) {
			int cmp = strbuf_cmp(&one, &two);

			hunk_no++;
			hunk = 0;
			if (cmp > 0) {
				strbuf_swap(&one, &two);
			}
			if (out) {
				fputs("<<<<<<<\n", out);
				fwrite(one.buf, one.len, 1, out);
				fputs("=======\n", out);
				fwrite(two.buf, two.len, 1, out);
				fputs(">>>>>>>\n", out);
			}
			if (sha1) {
				SHA1_Update(&ctx, one.buf, one.len + 1);
				SHA1_Update(&ctx, two.buf, two.len + 1);
			}
			strbuf_reset(&one);
			strbuf_reset(&two);
		} else if (hunk == 1)
			strbuf_addstr(&one, buf);
		else if (hunk == 2)
			strbuf_addstr(&two, buf);
		else if (out)
			fputs(buf, out);
	}
	strbuf_release(&one);
	strbuf_release(&two);
	...
}

When one or two are empty and the caller asked for checksumming,
the code still relies on one.buf being an allocated memory with
an extra NUL termination and tries to feed the NULL pointer to
SHA1_Update() with length of 1!

An obvious workaround is to say "strbuf_init(&one, !!sha1)" to
force the allocation.  However, because the second parameter to
strbuf_init() is defined to be merely a hint, we should not rely
on strbuf_init() with non-zero hint to have allocation from the
beginning.  It is assuming too much.

A more defensive way would be for the user to do something like:

	SHA1_Update(&ctx, one.buf ? one.buf : "", one.len + 1);
	SHA1_Update(&ctx, two.buf ? two.buf : "", two.len + 1);

which I am leaning towards, but this looks ugly.

I was already bitten by another bug in strbuf_setlen() that
shared the same roots; an empty strbuf can have two internal
representations ("alloc == 0 && buf == NULL" vs "alloc != 0 &&
buf != NULL") and they behave differently.

For example, this happens to be Ok but the validity of it is
subtle.  If a or b is empty, memcmp may get a NULL pointer but
we ask only 0 byte comparison.

        int strbuf_cmp(struct strbuf *a, struct strbuf *b)
        {
                int cmp;
                if (a->len < b->len) {
                        cmp = memcmp(a->buf, b->buf, a->len);
                        return cmp ? cmp : -1;
                } else {
                        cmp = memcmp(a->buf, b->buf, b->len);
                        return cmp ? cmp : a->len != b->len;
                }
        }

It might be an easier and safer fix to define that strbuf_init()
to always have allocation.  Use of a strbuf in the code _and_
not adding any contents to the buffer should be an exception and
avoiding malloc()/free() for that special case feels optimizing
for the wrong case.

However, there are strbuf instances that are not initialized
(i.e. in BSS or initialized by declaring with STRBUF_INIT), so
we still need to handle (.len == 0 && .alloc == 0) case
specially anyway.

It would be appreciated if somebody with a fresh pair of eyes
can go over the strbuf series one more time to make sure that we
do not try to blindly use buf.buf, assuming buf.buf[0] is NUL if
(buf.len == 0).
