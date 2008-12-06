From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Sat, 06 Dec 2008 13:28:50 -0800
Message-ID: <7v8wqtvvql.fsf@gitster.siamese.dyndns.org>
References: <4936AB74.3090901@jaeger.mine.nu>
 <20081206194034.GA18418@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 22:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L94jF-0001Ei-1p
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 22:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYLFV3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYLFV3D
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 16:29:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYLFV3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 16:29:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A6CD84038;
	Sat,  6 Dec 2008 16:28:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1BF8E84031; Sat,
  6 Dec 2008 16:28:53 -0500 (EST)
In-Reply-To: <20081206194034.GA18418@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 6 Dec 2008 14:40:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4635B8C-C3DC-11DD-92FF-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102477>

Jeff King <peff@peff.net> writes:

> tag: delete TAG_EDITMSG only on successful tag
>
> The user may put some effort into writing an annotated tag
> message. When the tagging process later fails (which can
> happen fairly easily, since it may be dependent on gpg being
> correctly configured and used), there is no record left on
> disk of the tag message.
>
> Instead, let's keep the TAG_EDITMSG file around until we are
> sure the tag has been created successfully. If we die
> because of an error, the user can recover their text from
> that file. Leaving the file in place causes no conflicts;
> it will be silently overwritten by the next annotated tag
> creation.
>
> This matches the behavior of COMMIT_EDITMSG, which stays
> around in case of error.

Thanks.  I love patches that addresses bugs during -rc period.

> There are two possible improvements I can think of:
>
>   - we can be more friendly about helping the user recover. Right now,
>     we don't tell them that their message was saved anywhere, and it
>     will be silently overwritten if they try another tag. I'm not sure
>     what would be the best way to go about that, though.
>
>   - the "path" variable became a little less local. It might be worth
>     giving it a better name ("editmsg_path" or similar), but keeping it
>     made the diff a lot less noisy (and it's still local to a fairly
>     simple function).

There is another.

    - the "path" variable is uninitialized if we do not start editor at
      all, so unlink(path) and free(path) have a very high chance of
      failing.

      I think you need [Update #1] below squashed in to fix this.

As to your first potential improvement, I think you could do something
like [Update #2] (on top of [Update #1], of course).

[Update #1]

diff --git c/builtin-tag.c w/builtin-tag.c
index ea596d2..8086b3a 100644
--- c/builtin-tag.c
+++ w/builtin-tag.c
@@ -260,7 +260,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	enum object_type type;
 	char header_buf[1024];
 	int header_len;
-	char *path;
+	char *path = NULL;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= OBJ_NONE)
@@ -314,8 +314,10 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		die("unable to write tag file");
 
-	unlink(path);
-	free(path);
+	if (path) {
+		unlink(path);
+		free(path);
+	}
 }
 
 struct msg_arg {

[Update #2]

diff --git i/builtin-tag.c w/builtin-tag.c
index 8086b3a..20c1c0e 100644
--- i/builtin-tag.c
+++ w/builtin-tag.c
@@ -253,6 +253,15 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 	free(buf);
 }
 
+static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
+{
+	if (sign && do_sign(buf) < 0)
+		return error("unable to sign the tag");
+	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
+		return error("unable to write tag file");
+	return 0;
+}
+
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
 		       unsigned char *prev, unsigned char *result)
@@ -309,11 +318,12 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (sign && do_sign(buf) < 0)
-		die("unable to sign the tag");
-	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
-		die("unable to write tag file");
-
+	if (build_tag_object(buf, sign, result) < 0) {
+		if (path)
+			fprintf(stderr, "What you edited in your editor is left in %s",
+				path);
+		exit(128);
+	}
 	if (path) {
 		unlink(path);
 		free(path);
