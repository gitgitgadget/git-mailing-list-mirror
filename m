From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 23:23:39 +0800
Message-ID: <41f08ee11003230823i1ca677b8q51b2413040c45c44@mail.gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <201003231222.40745.jnareb@gmail.com>
	 <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
	 <201003231449.42190.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 16:23:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu5xI-0003hE-BC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 16:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab0CWPXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 11:23:40 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:23916 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0CWPXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 11:23:39 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1570896qwh.37
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KeNNZdC3IVnfKR2VS6LNhthSbFBAp/q7TgzucjgZhbo=;
        b=sfG3PBp0UCjtfV+TewFPQHhP2becXA7zpWLcViOzfrm6LZ4Gd+XFcfStsFAuqZeQsO
         zHk6kHaJzKpV/rYUwR7cizfnaO+mkx0wFr7w1Uwdqo4yvqqNGwqWdhSNYnexYXJfo5M4
         d2siMO1h/+muzJPuQI7OKPjv9YQtIbb1eXWwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hzhagT2R16lwNk9gK3OZHnppt3sXsqI7aZBLkQ8y+WAj2WgRrlIue/rKKoZ+rewYct
         0HvRaevk0NF42UheeMflrSCfpt7cWgQOYvMZpFwXcogvlC3KGKkQv/+LJsMkrTmoOT0i
         IzqfrH+p8qsNlTfVTOGrDqcof89uWopNlliXo=
Received: by 10.229.221.14 with SMTP id ia14mr1171740qcb.8.1269357819106; Tue, 
	23 Mar 2010 08:23:39 -0700 (PDT)
In-Reply-To: <201003231449.42190.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143024>

Hi,

On Tue, Mar 23, 2010 at 9:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Try to come with the result of line-level history for some line in
> git sources "by hand": this would help in discussion about what
> line-level history browser should do, and perhaps even be first test
> of it (see e.g. tests for git-blame).

Thanks for your advice of coming with a real example, Jakub! And I can
give a not too trivial one, :)

If you look at the pretty.c line 1032 line, you will find a line like:

format_commit_message(commit, user_format, sb, context);

Take for example, we will trace the history of this line.
We will find that the first time this line appears:

@@ -900,18 +900,18 @@ char *reencode_commit_message(const struct
commit *commit, const char **encoding
...skipped...
        if (fmt == CMIT_FMT_USERFORMAT) {
-               format_commit_message(commit, user_format, sb, dmode);
+               format_commit_message(commit, user_format, sb, context);
                return;
        }
And we should trace the preimage, something like:
        if (fmt == CMIT_FMT_USERFORMAT) {
               format_commit_message(commit, user_format, sb, dmode);

We will find these below:
@@ -770,7 +775,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct com
        const char *encoding;

        if (fmt == CMIT_FMT_USERFORMAT) {
-               format_commit_message(commit, user_format, sb);
+               format_commit_message(commit, user_format, sb, dmode);
                return;
        }

Again:
+
+       if (fmt == CMIT_FMT_USERFORMAT) {
+               format_commit_message(commit, user_format, sb);
+               return;
+       }
+

Here, we find that the line is added from scratch and line level
history browser will do a code movement and copy matching try to find
whether this line if moved from other files.

And it is. In commit 93fc05eb9(Split off the pretty print stuff into
its own file), some code is moved from commit.c to pretty.c and this
line if from commit.c .

Ok, now, we will trace into commit.c for this line.
Again:
        char *reencoded;
        const char *encoding;
-       char *buf;

-       if (fmt == CMIT_FMT_USERFORMAT)
-               return format_commit_message(commit, user_format,
buf_p, space_p);
+       if (fmt == CMIT_FMT_USERFORMAT) {
+               format_commit_message(commit, user_format, sb);
+               return;
+       }

        encoding = (git_log_output_encoding
                    ? git_log_output_encoding

Now, we will trace the commit which produce the above preimage of the
diff hunk. And because there are four lines of the preimage in our
tracing window. We should follow any commit which intersect with these
four lines. Fortunately, there is only one commit.

@@ -1165,7 +1166,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
        char *buf;

        if (fmt == CMIT_FMT_USERFORMAT)
-               return format_commit_message(commit, msg, buf_p, space_p);
+               return format_commit_message(commit, user_format,
buf_p, space_p);

        encoding = (git_log_output_encoding
                    ? git_log_output_encoding


Again, we find:

        if (fmt == CMIT_FMT_USERFORMAT)
-               return format_commit_message(commit, msg, buf, space);
+               return format_commit_message(commit, msg, buf_p, space_p);

        encoding = (git_log_output_encoding

Again:
        char *encoding;

+       if (fmt == CMIT_FMT_USERFORMAT)
+               return format_commit_message(commit, msg, buf, space);
+
        encoding = (git_log_output_encoding
                    ? git_log_output_encoding

And here, finally, we reach a place where the code is added from
scratch and not copied/moved from other place.

Line level history browser will just display all the related diff to
users and trace the code modification/move/copy.

It traces the preimage of the minimum related diff hunk carefully, if
there is any case that there are more than one commit intersect with
the preimage, we will stop and ask the users to select which way to go
on tracing.

I hope this can help us to discuss the problem, thanks!

Regards!
Bo
