From: Ryan Flynn <parseerror@gmail.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sun, 9 Aug 2009 20:23:18 -0400
Message-ID: <a3f15ee60908091723l3e8a29adw8fbc990f4b0925db@mail.gmail.com>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
	 <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
	 <7v3a81a13z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 02:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaIfs-0002I7-Ut
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 02:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbZHJAXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2009 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZHJAXT
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 20:23:19 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:58197 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbZHJAXS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 20:23:18 -0400
Received: by vws2 with SMTP id 2so2419938vws.4
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kk1KjEnn+o7qSpBgjcFVXf8XisQpgjxa/xu7zfiHfoM=;
        b=Z6bnlWbGXENvCSfru/N0whlYgFueg4ND7MGZyZi28yVMQM71jmtBlsXCiquZ+LFJuq
         vCzIzHRPcaY52hJARZ171J7hOztQ6PGwnkGXAXx4o6bCQNKd02tNGS5EDD0Ku7UZNvC3
         kq6Lk+cTBqlBOcUYnDWNy5wBcrBFhlNgPDpg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uV1jtbjddB3Gx0r24w265fu8JSNPPy1NDx3W2l5C6UablYM43tnfNsZ2uRhZlu8aGc
         I143EUZmLFakds6s6GBCe5W/04eU7O6BZLtFYH5UbfBZVQlpj4XFPJTfunpDf4M0XVXs
         DQ6oceZVvrJ3kHnrP9/jyClI1jSPrarGt1Lrg=
Received: by 10.220.76.79 with SMTP id b15mr3784613vck.76.1249863798661; Sun, 
	09 Aug 2009 17:23:18 -0700 (PDT)
In-Reply-To: <7v3a81a13z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125392>

On Sun, Aug 9, 2009 at 3:38 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ryan Flynn <parseerror@gmail.com> writes:
>>
>>> given n, tried to find i greater than n via i=3D1, iterate i *=3D 1=
0.
>>> given n sufficiently close to UINT_MAX this will overflow; which ca=
n
>>> produce i=3D=3D0, which results in an infinite loop. iteratively di=
viding
>>> n /=3D 10 does not have this problem, and though division is slower=
 than
>>> multiplication this only runs once per `git format-patch
>>> --cover-letter`
>>>
>>> Signed-off-by: pizza <parseerror@gmail.com>
>>
>> Pizza?
>>
>> This is somewhat amusing.
>>
>> =A0- digits_in_number() is called only with opt->total that is "int"=
;
>>
>> =A0- opt->total is the total number of patches.
>>
>> =A0- the return value is used like this:
>>
>> =A0 =A0 =A0sprintf(buf, "%0*d", digits_in_number(opt->total), opt->n=
r);
>>
>> =A0 =A0and opt->nr runs from 1 to opt->total; the use of "d" would b=
e already
>> =A0 =A0wrong anyway even if you computed digits_in_number() correctl=
y.
>>
>> Perhaps we should get rid of this function altogether?
>
> Or perhaps something stupid like this...
>
> =A0builtin-log.c | =A0 =A06 +++++-
> =A0log-tree.c =A0 =A0| =A0 12 +-----------
> =A0revision.h =A0 =A0| =A0 =A02 +-
> =A03 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index 3817bf1..321e8f5 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -1096,8 +1096,12 @@ int cmd_format_patch(int argc, const char **ar=
gv, const char *prefix)
> =A0 =A0 =A0 =A0total =3D nr;
> =A0 =A0 =A0 =A0if (!keep_subject && auto_number && total > 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0numbered =3D 1;
> - =A0 =A0 =A0 if (numbered)
> + =A0 =A0 =A0 if (numbered) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char num_buf[64];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev.total =3D total + start_number - 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(num_buf, "%d", rev.total);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev.num_width =3D strlen(num_buf);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (in_reply_to || thread || cover_letter)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev.ref_message_ids =3D xcalloc(1, siz=
eof(struct string_list));
> =A0 =A0 =A0 =A0if (in_reply_to) {
> diff --git a/log-tree.c b/log-tree.c
> index 6f73c17..0d32a6c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -158,16 +158,6 @@ static void append_signoff(struct strbuf *sb, co=
nst char *signoff)
> =A0 =A0 =A0 =A0strbuf_addch(sb, '\n');
> =A0}
>
> -static unsigned int digits_in_number(unsigned int number)
> -{
> - =A0 =A0 =A0 unsigned int i =3D 10, result =3D 1;
> - =A0 =A0 =A0 while (i <=3D number) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i *=3D 10;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 result++;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return result;
> -}
> -
> =A0static int has_non_ascii(const char *s)
> =A0{
> =A0 =A0 =A0 =A0int ch;
> @@ -212,7 +202,7 @@ void log_write_email_headers(struct rev_info *opt=
, struct commit *commit,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snprintf(buffer, sizeof(buffer),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Subject: [%s %0*d/%d=
] ",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt->subject_prefix,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0digits_in_number(opt=
->total),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0opt->num_width,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opt->nr, opt->total);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0subject =3D buffer;
> =A0 =A0 =A0 =A0} else if (opt->total =3D=3D 0 && opt->subject_prefix =
&& *opt->subject_prefix) {
> diff --git a/revision.h b/revision.h
> index fb74492..21e4d9d 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -84,7 +84,7 @@ struct rev_info {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0abbrev;
> =A0 =A0 =A0 =A0enum cmit_fmt =A0 commit_format;
> =A0 =A0 =A0 =A0struct log_info *loginfo;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 nr, total;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 nr, total, num_width;
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0*mime_boundary;
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0*patch_suffix;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 numbered_files;
>

why carry around a piece of information that is only used in one place
and is not expensive to calculate? how about a middle-ground such as:

diff --git a/log-tree.c b/log-tree.c
index 6f73c17..4888518 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -158,14 +158,11 @@ static void append_signoff(struct strbuf *sb,
const char *signoff)
        strbuf_addch(sb, '\n');
 }

-static unsigned int digits_in_number(unsigned int number)
+static int digits_in_number(int number)
 {
-       unsigned int i =3D 10, result =3D 1;
-       while (i <=3D number) {
-               i *=3D 10;
-               result++;
-       }
-       return result;
+  static char num_buf[64];
+  sprintf(num_buf, "%u", number);
+  return (int)strlen(num_buf);
 }

 static int has_non_ascii(const char *s)
