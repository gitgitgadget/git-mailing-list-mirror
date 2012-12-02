From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Sun, 02 Dec 2012 22:25:52 +0100
Message-ID: <50BBC760.7030208@poczta.fm>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm> <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfH3O-0003RZ-3O
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 22:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab2LBVZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 16:25:59 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:39867 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab2LBVZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 16:25:58 -0500
Received: from [192.168.0.13] (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun,  2 Dec 2012 22:25:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120825 Thunderbird/10.0.6
In-Reply-To: <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.5
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1354483554;
	bh=PkkkhQZJiOMs5okQ6kKcPyjae57UNNJIjuW1E9w3peo=;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:
	 Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:
	 Content-Transfer-Encoding:X-Interia-Antivirus;
	b=MHBhDdywmz1YtZUgIUsfnwb1/ZMb1N7IfW0NC7vA5Oj7kvBNAI/waW4J13rEqnBd+
	 VrfsD8FxVFH25a3DVWZ4j5SFoCX3wRqn5ES5L+6NM4KJ3pyMeVpDZ8zMzLZehn4Rvn
	 vmr3yic33oT0hbP9sQxt0fbinSPhYfuvVe8fThxM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211020>

W dniu 02.12.2012 03:16, Junio C Hamano pisze:
> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>=20
>> Enable hiding of tags displayed in the tree as yellow labels.
>> If a repository is used together with a system like Gerrit
>> there may be quite a lot of tags used to control building
>> and there may be hardly any place left for commit subjects.
>>
>> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>> ---
>=20
> Paul, this patch is not done against your tree (does not have gitk
> at the top-level),

I did it on the master from github. Should I rebase it onto something e=
lse?

> but other than that, the change mimics the way
> existing hideremoes is implemented and looks reasonable to me.
>=20
> We _may_ want to unify these two "hidestuff" into a list of patterns
> that hides any ref that match one of the patterns in the list, e.g.
>=20
> 	set hidestuff {refs/heads/*/* refs/tags/* refs/remotes/*}
>=20
> may hide all tags, all remote-tracking branches and local branches
> that have a slash in their names.
>=20
> But that is an independent change that can come later.

This would make much more sense with gitk being abel to read a
per-repository configuration file, say from [file join $gitdir k] and
then save it there (but only if the file exists). I will send a separat=
e
patch in a moment.

>>  gitk-git/gitk |   23 +++++++++++++++--------
>>  1 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index d93bd99..274b46b 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -1754,7 +1754,7 @@ proc readrefs {} {
>>      global tagids idtags headids idheads tagobjid
>>      global otherrefids idotherrefs mainhead mainheadid
>>      global selecthead selectheadid
>> -    global hideremotes
>> +    global hideremotes hidetags
>> =20
>>      foreach v {tagids idtags headids idheads otherrefids idotherref=
s} {
>>  	catch {unset $v}
>> @@ -1776,6 +1776,7 @@ proc readrefs {} {
>>  	    set headids($name) $id
>>  	    lappend idheads($id) $name
>>  	} elseif {[string match "tags/*" $name]} {
>> +	    if {$hidetags} continue
>>  	    # this lets refs/tags/foo^{} overwrite refs/tags/foo,
>>  	    # which is what we want since the former is the commit ID
>>  	    set name [string range $name 5 end]
>> @@ -2702,7 +2703,7 @@ proc savestuff {w} {
>>      global cmitmode wrapcomment datetimeformat limitdiffs
>>      global colors uicolor bgcolor fgcolor diffcolors diffcontext se=
lectbgcolor
>>      global autoselect autosellen extdifftool perfile_attrs markbgco=
lor use_ttk
>> -    global hideremotes want_ttk
>> +    global hideremotes hidetags want_ttk
>> =20
>>      if {$stuffsaved} return
>>      if {![winfo viewable .]} return
>> @@ -2725,6 +2726,7 @@ proc savestuff {w} {
>>  	puts $f [list set autosellen $autosellen]
>>  	puts $f [list set showneartags $showneartags]
>>  	puts $f [list set hideremotes $hideremotes]
>> +	puts $f [list set hidetags $hidetags]
>>  	puts $f [list set showlocalchanges $showlocalchanges]
>>  	puts $f [list set datetimeformat $datetimeformat]
>>  	puts $f [list set limitdiffs $limitdiffs]
>> @@ -10864,7 +10866,7 @@ proc create_prefs_page {w} {
>>  proc prefspage_general {notebook} {
>>      global NS maxwidth maxgraphpct showneartags showlocalchanges
>>      global tabstop limitdiffs autoselect autosellen extdifftool per=
file_attrs
>> -    global hideremotes want_ttk have_ttk
>> +    global hideremotes hidetags want_ttk have_ttk
>> =20
>>      set page [create_prefs_page $notebook.general]
>> =20
>> @@ -10887,6 +10889,9 @@ proc prefspage_general {notebook} {
>>      ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote ref=
s"] \
>>  	-variable hideremotes
>>      grid x $page.hideremotes -sticky w
>> +    ${NS}::checkbutton $page.hidetags -text [mc "Hide tag labels"] =
\
>> +	-variable hidetags
>> +    grid x $page.hidetags -sticky w
>> =20
>>      ${NS}::label $page.ddisp -text [mc "Diff display options"]
>>      grid $page.ddisp - -sticky w -pady 10
>> @@ -10988,7 +10993,7 @@ proc doprefs {} {
>>      global oldprefs prefstop showneartags showlocalchanges
>>      global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor m=
arkbgcolor
>>      global tabstop limitdiffs autoselect autosellen extdifftool per=
file_attrs
>> -    global hideremotes want_ttk have_ttk
>> +    global hideremotes hidetags want_ttk have_ttk
>> =20
>>      set top .gitkprefs
>>      set prefstop $top
>> @@ -10997,7 +11002,7 @@ proc doprefs {} {
>>  	return
>>      }
>>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
>> -		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
>> +		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk=
} {
>>  	set oldprefs($v) [set $v]
>>      }
>>      ttk_toplevel $top
>> @@ -11117,7 +11122,7 @@ proc prefscan {} {
>>      global oldprefs prefstop
>> =20
>>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
>> -		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
>> +		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk=
} {
>>  	global $v
>>  	set $v $oldprefs($v)
>>      }
>> @@ -11131,7 +11136,7 @@ proc prefsok {} {
>>      global oldprefs prefstop showneartags showlocalchanges
>>      global fontpref mainfont textfont uifont
>>      global limitdiffs treediffs perfile_attrs
>> -    global hideremotes
>> +    global hideremotes hidetags
>> =20
>>      catch {destroy $prefstop}
>>      unset prefstop
>> @@ -11177,7 +11182,8 @@ proc prefsok {} {
>>  	  $limitdiffs !=3D $oldprefs(limitdiffs)} {
>>  	reselectline
>>      }
>> -    if {$hideremotes !=3D $oldprefs(hideremotes)} {
>> +    if {$hideremotes !=3D $oldprefs(hideremotes) ||
>> +        $hidetags !=3D $oldprefs(hidetags)} {
>>  	rereadrefs
>>      }
>>  }
>> @@ -11601,6 +11607,7 @@ set cmitmode "patch"
>>  set wrapcomment "none"
>>  set showneartags 1
>>  set hideremotes 0
>> +set hidetags 0
>>  set maxrefs 20
>>  set maxlinelen 200
>>  set showlocalchanges 1
>=20


--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99=
ska, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziej=
ska.  (c)PP
