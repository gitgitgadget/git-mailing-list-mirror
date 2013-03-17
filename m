From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Sun, 17 Mar 2013 12:31:01 +0700
Message-ID: <CACsJy8A3NaA=faQoGhCDWNB7CKHQ2WF_5T0tf9z7mGTYFdreEg@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-23-git-send-email-pclouds@gmail.com> <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
 <CACsJy8DUb5j0of=cuQje5cRWLwyi-MiH-d-RsyBiPOjaD1Tntg@mail.gmail.com> <7vehfetycj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6CV-0001qd-81
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab3CQFbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 01:31:32 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59120 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3CQFbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 01:31:31 -0400
Received: by mail-ob0-f170.google.com with SMTP id wc20so4485677obb.29
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=bxIhdp3N9MqFyaX2oqdBmPvmmZ+JR7lseyg3gwC3TwQ=;
        b=cH/J6/B20CT4WfEFt0p24CLM7zNpY/qsxiWKpgkS3dN4dPG4Q38tsOI7pEZuMAmG8E
         4TEhU5NAwi+LR6/bXDiRslwbjs5RVd3PxfaKT5heUKlbPEqB23oPxwcwbAy3dspoiLR2
         e2doAXAKgzoJ4xfFxNf38B/DJibIrxGyVyAnwfCGlJIJhtw7l/LyaUC6aVoEd3p9OBhD
         7qSgSDyVztEgvhQRXRLhFzUMndakAEAMxF4JBliOlsQ4TA3ccXXEZps4+D4qmGd1ZYuM
         WJZGFQ/jV5+3VNDsnZnQZIsVAHqcV+bFVnqbiIqhEI5c6e++IpLInE2ipkn6M1EFnxsy
         yiuQ==
X-Received: by 10.182.72.5 with SMTP id z5mr5211802obu.24.1363498291181; Sat,
 16 Mar 2013 22:31:31 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sat, 16 Mar 2013 22:31:01 -0700 (PDT)
In-Reply-To: <7vehfetycj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218330>

On Sun, Mar 17, 2013 at 12:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Mar 16, 2013 at 12:56 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> @@ -232,11 +228,18 @@ static int path_exists(struct tree *tree, co=
nst char *path)
>>>>  static void parse_pathspec_arg(const char **pathspec,
>>>>               struct archiver_args *ar_args)
>>>>  {
>>>> -     ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec=
);
>>>> +     /*
>>>> +      * must be consistent with parse_pathspec in path_exists()
>>>> +      * Also if pathspec patterns are dependent, we're in big
>>>> +      * trouble as we test each one separately
>>>> +      */
>>>> +     parse_pathspec(&ar_args->pathspec, 0,
>>>> +                    PATHSPEC_PREFER_FULL,
>>>> +                    "", pathspec);
>>>>       if (pathspec) {
>>>>               while (*pathspec) {
>>>>                       if (!path_exists(ar_args->tree, *pathspec))
>>>> -                             die("path not found: %s", *pathspec)=
;
>>>> +                             die(_("pathspec '%s' did not match a=
ny files"), *pathspec);
>>>>                       pathspec++;
>>>>               }
>>>
>>> You do not use ar_args->pathspec even though you used parse_pathspe=
c()
>>> to grok it?  What's the point of this change?
>>
>> parse_pathspec() here is needed because write_archive_entries needs =
it
>> later.
>
> That is not the issue I was pointing out.  Even though you parse the
> pathspec into args->pathspec, the "if() { while () {} }" here still
> uses strings contained in **pathspec, as if they are literal strings
> and not ":(glob)Documentation" and such, and will not match the named
> directory.

No, the literal strings are reparsed in path_exists() before being fed
to read_tree_recursive. So ":(glob)Documentation" should match the
tree "Documentation".

> Technically, erroring out saying "':(glob)Documentation' does not exi=
st
> as a path in the tree" is correct, but it would be nicer to have the
> code inspect parse_pathspec() result and independently barf, saying
> "this command does not support magic pathspecs, give me leading paths
> and nothing else", until we do support magic pathspecs, no?
--=20
Duy
