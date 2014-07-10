From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Thu, 10 Jul 2014 11:30:40 +0200
Message-ID: <CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Agh-0004Nn-3W
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaGJJam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:30:42 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:35328 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaGJJal (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:30:41 -0400
Received: by mail-vc0-f169.google.com with SMTP id la4so9987740vcb.14
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 02:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CUcmuqqb9Dl149xk5Mg0XQsqTLEb72ZzaqisQ6E7uxk=;
        b=QuCMWZ49qlbcMt4aOLy5gCKl2IssIMc2GTFv9jgQNH329/TQEovGX9DAV+cUaUpLQd
         tAs2FBctAnhu+Bg/SCFxiXc3GdZnz0R+E1MKWk3H7AZEWncfME87fxjbYxKA/0HgRVfh
         Ax1e1fHkYUI/lD8kN0QVV18nG1dvbgmy21qD4ox7eIabDpI56enqupfQedWlNH0T60fJ
         rBc4/OBwAnNmRYHLwfb8H3M4lgFnoxYbun7z7DBA4mdUand+4ovm24cQTFhIi6BXz1fx
         r7PxO+/Fe+A3+byt7QdVgU/sI8cqH24JPBa6UvKAQ3Cwwa34o6zL2cZeSrfnKn/v6IfV
         TPuA==
X-Received: by 10.58.182.105 with SMTP id ed9mr44849590vec.16.1404984640333;
 Thu, 10 Jul 2014 02:30:40 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Thu, 10 Jul 2014 02:30:40 -0700 (PDT)
In-Reply-To: <xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253180>

On Wed, Jul 9, 2014 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> +static void replace_parents(struct strbuf *buf, int argc, const char **argv)
>> +{
>> +     struct strbuf new_parents = STRBUF_INIT;
>> +     const char *parent_start, *parent_end;
>> +     int i;
>> +
>> +     /* find existing parents */
>> +     parent_start = buf->buf;
>> +     parent_start += 46; /* "tree " + "hex sha1" + "\n" */
>> +     parent_end = parent_start;
>> +
>> +     while (starts_with(parent_end, "parent "))
>> +             parent_end += 48; /* "parent " + "hex sha1" + "\n" */
>> +
>> +     /* prepare new parents */
>> +     for (i = 1; i < argc; i++) {
>
> It looks somewhat strange that both replace_parents() and
> create_graft() take familiar-looking <argc, argv> pair, but one
> ignores argv[0] and uses the remainder and the other uses argv[0].
> Shouldn't this function consume argv[] starting from [0] for
> consistency?  You'd obviously need to update the caller to adjust
> the arguments it gives to this function.

Ok, will do.

>> +static int create_graft(int argc, const char **argv, int force)
>> +{
>> +     unsigned char old[20], new[20];
>> +     const char *old_ref = argv[0];
>> +...
>> +
>> +     replace_parents(&buf, argc, argv);
>> +
>> +     if (write_sha1_file(buf.buf, buf.len, commit_type, new))
>> +             die(_("could not write replacement commit for: '%s'"), old_ref);
>> +
>> +     strbuf_release(&buf);
>> +
>> +     if (!hashcmp(old, new))
>> +             return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
>
> Is this really an error?  It may be a warning-worthy situation for a
> user or a script to end up doing a no-op graft, e.g.
>
>         git replace --graft HEAD HEAD^
>
> but I wonder if it is more convenient to signal an error (like this
> patch does) or just ignore the request and return without adding the
> replace ref.

As the user might expect that a new replace ref was created on success
(0 exit code), and as we should at least warn if we would create a
commit that is the same as an existing one, I think it is just simpler
to error out in this case.

Though maybe we could use a special exit code (for example 2) in this
case, so that the user might more easily ignore this error in a
script.

> Other than these two points, looks good to me.

Thanks,
Christian.
