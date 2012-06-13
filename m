From: duperrav@minatec.inpg.fr
Subject: Re: [PATCHv2] git bisect old/new
Date: Wed, 13 Jun 2012 20:06:06 +0200
Message-ID: <20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <7vr4tkhys5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerxP-00027H-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab2FMSGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 14:06:11 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:42359 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754507Ab2FMSGK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 14:06:10 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id D2BBE1A0258;
	Wed, 13 Jun 2012 20:06:06 +0200 (CEST)
Received: from AGrenoble-257-1-61-134.w86-206.abo.wanadoo.fr
 (AGrenoble-257-1-61-134.w86-206.abo.wanadoo.fr [86.206.156.134]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Wed, 13 Jun
 2012 20:06:06 +0200
In-Reply-To: <7vr4tkhys5.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199915>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> Some commands are still not available for old/new:
>>
>>      * git bisect start [<new> [<old>...]] is not possible: the
>>        commits will be treated as bad and good.
>>      * git rev-list --bisect does not treat the revs/bisect/new and
>>        revs/bisect/old-SHA1 files.
>>      * thus, git bisect run <cmd> is not available for new/old.
>>      * git bisect visualize seem to work partially: the tags are
>>        displayed correctly but the tree is not limited to the bisect
>>        section.
>
> Would be easier to review if the subject is marked as RFC while
> these todo items are still there.
>
> Also before going too far into the implementation, I think it is a
> good idea to think how you are going to address the above issues. I
> suspect the changes to bisect.c will have to be vastly different
> depending on that plan.

         * git bisect start [<new> [<old>...]]:

The idea would be to add a "--new" option to start in new/old mode.

         * git rev-list --bisect:

I see two solutions for this:

         - read revisions from both refs/bisect/bad and refs/bisect/new
           (resp. refs/bisect/good and refs/bisect/old).

         - read revisions only from refs/bisect/bad and refs/bisect/goo=
d
           when the BISECT_TERMS doesn't exist or contains bad/good
           and
           read revisions only from refs/bisect/new and refs/bisect/old
           when the BISECT_TERMS exists and contains new/old.

I prefer the latter because I don't really know how reading all files
will affect the calls of "git rev-list" outside of a bisect session and
the two types of files should not be present simultaneously anyway.

> What happens when you do:
>
> 	git bisect start
>         git bisect new HEAD
>         git bisect old v1.0.0
>
> and then
>
>         git bisect bad v1.2.0
>
> Does it error out?  For that matter, what happens if you do this?
>
> 	git bisect start
>         git bisect new HEAD
> 	git bisect good v1.0.0
>

In both cases, the `git bisect good`/`git bisect bad`command is
considered invalid. The message
"Invalid command : you're currently in a new/old bisect."
is displayed and the bisect section is not reseted.
Same thing happens if you try to use new/old in a bad/good
bisect session.


>> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
>>  	if (is_expected_rev(current_bad_sha1)) {
>>  		char *bad_hex =3D sha1_to_hex(current_bad_sha1);
>>  		char *good_hex =3D join_sha1_array_hex(&good_revs, ' ');
>> +		if (!strcmp(bisect_bad,"bad")) {
>
> s/,/, /;
>
> But see below.  It feels wrong to always running string comparison
> when we know there are either good/bad mode or old/new mode.
>
>> @@ -889,6 +900,31 @@ static void show_diff_tree(const char *prefix, =
=20
>> struct commit *commit)
>>  }
>>
>>  /*
>> + * The terms used for this bisect session are stocked in
>> + * BISECT_TERMS: it can be bad/good or new/old.
>> + * We read them and stock them to adapt the messages
>> + * accordingly. Default is bad/good.
>> + */
>> +void read_bisect_terms(void)
>> +{
>> +	struct strbuf str =3D STRBUF_INIT;
>> +	const char *filename =3D git_path("BISECT_TERMS");
>> +	FILE *fp =3D fopen(filename, "r");
>> +
>> +	if (!fp) {
>> +		bisect_bad =3D "bad";
>> +		bisect_good =3D "good";
>> +	} else {
>> +	strbuf_getline(&str, fp, '\n');
>> +	bisect_bad =3D strbuf_detach(&str, NULL);
>> +	strbuf_getline(&str, fp, '\n');
>> +	bisect_good =3D strbuf_detach(&str, NULL);
>> +	}
>> +	strbuf_release(&str);
>> +	fclose(fp);
>> +}
>
> While this is not wrong per-se, I am not sure if storing and reading
> two lines from this file is really worth the trouble.
>
> Wouldn't it be easier to change the convention so that the presense
> of BISECT_OLDNEW file signals that the program is working in the
> old/new mode as opposed to the traditional good/bad mode, or perhaps
> a single line "true" or "false" in the file tells us if we are in
> OLDNEW mode, or something?

If there is consensus around the fact that no other terms will be added
after old/new, only checking if the file is present would be easier
indeed.

Thanks,

Valentin
