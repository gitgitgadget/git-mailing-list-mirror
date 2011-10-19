From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git-gui: still smartcase (and pull into git.git)
Date: Wed, 19 Oct 2011 16:59:59 +0200
Message-ID: <CAKPyHN0KCwDu2-JXAEk4wAvfOqE3jHY63aG6R9YSOoLoKwWGgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 17:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGXcl-0004PY-03
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 17:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab1JSPAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 11:00:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43371 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1JSO77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 10:59:59 -0400
Received: by vws1 with SMTP id 1so1292557vws.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uB4D7oFiEl0gBoWhR0Lk2sXQ2UXxhyvycK/2uYKsERw=;
        b=A9K1XaxpyOLbyG5AThZu1foMZQ5wD7rVVv0q2a4dIfRwwJkCIL1F4chArcndxicGVJ
         v9Q96szxIkm6ZrTuu00vf9aKOd7t9hTv+2UMgNTVySt0DqrNZ3DoB/tmKaM+/Dt0VtmN
         /oZMn0rb1J8tcxZkYFwOqYEdCsesOh3E6F3tQ=
Received: by 10.52.173.168 with SMTP id bl8mr7082561vdc.85.1319036399111; Wed,
 19 Oct 2011 07:59:59 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Wed, 19 Oct 2011 07:59:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183931>

[ Cc'ing git@vger, because its not that private anymore ;-) ]

On Wed, Oct 19, 2011 at 15:06, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>
> I've applied the last of your set of patches to the git-gui repositor=
y
> now. The search series with the regexp and smartcase search. I added
> themed entry fields using similar code to that I posted but also
> handling xp/vista and dealing with non-themed Tk.
>
> I had to add a trap to deal with partial regexp's. If you tried to
> enable regexp and then entered [Cc]opyrigth it would raise an error
> after opening the brace as its not a valid regexp. Handled by catchin=
g
> and returning {} which yields a pink background until the expression
> becomes valid again which I think works well.

Thanks for catching this.

>
> As I don't like the smartcase mode I've added a commit to only enable=
 it
> if gui.search.smartcase is enabled. It looks like this was your
> intention anyway but the mode was always enabled. What I don't like
> about it is that you can't uncheck the Case checkbutton if there is a
> capital letter in the search box.

I checked my inspiration for this, it's a patch to the NEdit editor
for it's incremental searchbar, and you can't uncheck the Case
checkbutton there too, if an capital letter is entered. Other
smart-case implementation I know of, aren't incremental, for example
less with it's -i option. So duno what should happen. It does
definitive makes no sense to enter 'giT' and searching
case-insensitive, in my opinion.

I also have incorporated Andrew's suggestion to reset the case flag
when the user cleared the entry. Unfortunately, I can't send an
updated patch currently, maybe tomorrow, here is just the commit,
before fixing up the patch, which is now in your master.

 commit af9e02860629f9da20a9434bfec74c115916f4e2
Author: Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue Oct 18 19:43:44 2011 +0200

    searchbar: reset case flag after the user cleared the text

diff --git a/lib/search.tcl b/lib/search.tcl
index 58e6852..3388eb9 100644 lib/search.tcl
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -155,10 +155,10 @@ method _incrsearch {} {
 	if {[catch {$ctext index anchor}]} {
 		$ctext mark set anchor [_get_new_anchor $this]
 	}
-	if {[regexp {[[:upper:]]} $searchstring]} {
-		set casesensitive 1
-	}
 	if {$searchstring ne {}} {
+		if {[regexp {[[:upper:]]} $searchstring]} {
+			set casesensitive 1
+		}
 		set here [_do_search $this anchor mlen]
 		if {$here ne {}} {
 			$ctext see $here
@@ -169,6 +169,9 @@ method _incrsearch {} {
 		} else {
 			$w.ent configure -background lightpink
 		}
+	} else {
+		# reset case sensitivity, when the user cleared the entry field
+		set casesensitive $default_casesensitive
 	}
 }

This should probably be now guarded by the new smartcase flag.

On the other hand, maybe we should change the 'gui.search.smartcase'
into 'gui.search.case' with 3 values case/nocase/smart?

>
> All pushed to master now at repo.or.cz. We should see it all end up i=
n
> 1.7.8 I reckon.

But I saw that Juno has already pulled your gitgui-0.15.0 tag, which
was at 843d6597 at that time, and now you moved the tag :(

Bert

>
> Thanks,
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
