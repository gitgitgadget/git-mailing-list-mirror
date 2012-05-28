From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Mon, 28 May 2012 12:54:32 +0200
Message-ID: <20120528125432.Horde.KyJxSnwdC4BPw1lo0-ZkrQA@webmail.minatec.grenoble-inp.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v1um47vik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 13:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6a-0007bQ-8p
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab2E1L1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:15 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:56822 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908Ab2E1L1O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 07:27:14 -0400
X-Greylist: delayed 1958 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2012 07:27:14 EDT
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 36ED71A025D;
	Mon, 28 May 2012 12:54:33 +0200 (CEST)
Received: from 183.24.91.79.rev.sfr.net (183.24.91.79.rev.sfr.net
 [79.91.24.183]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 28 May 2012 12:54:32 +0200
In-Reply-To: <7v1um47vik.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198699>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +	int unmerged_state =3D 0;
>> +	int rebase_state =3D 0;
>> +	int rebase_interactive_state =3D 0;
>> +	int am_state =3D 0;
>> +	int bisect_state =3D 0;
>
> These are not independent (you cannot be in bisect and am at the
> same time).  Why five independent variables?

Some of these variables are independant. We can be in rebase and
bisect at the same time and, as Matthieu said, we can do an am during
a bisect. However, there are dependant cases such as you cannot do a
rebase during an am.


>> +	for (i =3D 0; i < s->change.nr; i++) {
>> +		struct wt_status_change_data *d;
>> +		struct string_list_item *it;
>> +		it =3D &(s->change.items[i]);
>> +		d =3D it->util;
>> +		if (d->stagemask) {
>> +			conflict =3D 1;
>> +			continue;
>> +		}
>> +	}
>
> That "continue" looks like a no-op.  Mental note: conflict seems to
> remember if there was any path that was unmerged.

You're right. It should be a "break" instead of "continue".


> Such a code structure invites bugs and missed cases (e.g. you do not
> seem to say anything after you detect that you are in "am").

In fact, the case of 'am' is not implemented in this patch. It's suppos=
ed
to be added in the next patch.

>
>> +	if(rebase_state || rebase_interactive_state) {
>> +		if (conflict) {
>> +			status_printf_ln(s, c, _("You are currently rebasing: fix =20
>> conflicts and then run \"git rebase -- continue\"."));
>> +			status_printf_ln(s, c, _("If you would prefer to skip this =20
>> patch, instead run \"git rebase --skip\"."));
>> +			status_printf_ln(s, c, _("To check out  the original branch and =
=20
>> stop rebasing run \"git rebase --abort\"."));
>> +		}
>> +		else {
>
> 	if (...) {
> 		...
> 	} else {
> 		...
> 	}
>
>> +			if (rebase_state)
>
> Why extra level of nesting?

The 'conflict' variable stands for the case when we're in a conflict =20
before resolving
it (with 'git add'), as we distinguish the warning messages for when =20
we're before
resolving a conflict and after resolving it. So, the case with =20
"conflict" can happen in
both cases rebase_state and rebase_interactive_state but the warning =20
messages are still specifical
for the rebase cases. However, There are still specifical messages for =
=20
when you are
in rebase_state or in rebase_interactive_state.

>
> Oh, another thing.  Perhaps these (both detection logic and output)
> should be protected with a new advise.* configuration variable, no?

Yes, We think that it would be wise to add a new advice.* config variab=
le
to control the display of the new warning messages.
