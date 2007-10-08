From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Mon, 8 Oct 2007 16:16:51 +0200
Message-ID: <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
References: <11917925011987-git-send-email-prohaska@zib.de> <20071007233023.GE2137@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-14-944930427
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 16:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IetOP-0005DM-DT
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 16:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbXJHOPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbXJHOPY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 10:15:24 -0400
Received: from mailer.zib.de ([130.73.108.11]:56573 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXJHOPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 10:15:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l98EFIM9012453;
	Mon, 8 Oct 2007 16:15:18 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l98EFIqI019870
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 8 Oct 2007 16:15:18 +0200 (MEST)
In-Reply-To: <20071007233023.GE2137@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60323>


--Apple-Mail-14-944930427
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Shawn,
I attached two patches. They should eventually be both squashed into  
one.
You can also cherry pick them from work/setup-preview in 4msysgit.
I'm not yet fully convinced of the performance of the second patch.
It is far from optimal, although it might be sufficient.

If you're satisfied with the current implementation you can squash them
into a single commit; or ask me to do that.

More comments below, after the summary.


commit a483fdd562d6c44d68a998224e0bbb17933b624a
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Mon Oct 8 08:25:47 2007 +0200

     git-gui: offer a list of recent repositories on startup

     If git-gui is started outside a work tree the repository
     chooser will offer a list of recently opend repositories.
     Clicking on an entry directly opens the repository.

     The list of recently opened repositories is stored in the
     config as gui.recentrepos. If the list grows beyond 10
     entries it will be truncated.

     Note, only repositories that are opened through the
     repository chooser will get added to the recent list.
     Repositories opened from the shell will not yet be added.

     Signed-off-by: Steffen Prohaska <prohaska@zib.de>

commit a9f083e83717eef91ba8842ece4a3ec0824126af
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Mon Oct 8 08:14:34 2007 +0200

     git-gui: handle list of recent repos as multi config gui.recentrepo

     Instead of encoding the list of recently opened repositories
     in a single config line, this commit uses multiple lines of
     gui.recentrepo.

     An advantage is that the solution makes the list explicit
     on the git config level. This may be easier to understand
     if the user wants to look at the configuration.

     A disadvantage (of the current implementation) is that it
     requires more git config calls to manage the list. This could
     be optimized. But maybe not required because the list is only
     updated on opening a new repository, which is already a quite
     expensive operation.

     Signed-off-by: Steffen Prohaska <prohaska@zib.de>


On Oct 8, 2007, at 1:30 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>
>> +	label $w_body.space
>> +	label $w_body.recentlabel \
>> +		-anchor w \
>> +		-text "Select Recent Repository:"
>
> This string needs to be i18n'd with [mc ...].

changed in first patch.

>> +	listbox $w_body.recentlist \
>
> Please make a field in this class called say "w_recentlist"
> so you can use that field name instead of $w_body.recentlist.
> This simplifies the code if we ever have to change the actual path
> that the widget resides at, such as to alter the layout.

changed in first patch.


>> +proc _append_recentrepos {path} {
>> +	set recent [get_config gui.recentrepos]
>> +	if {[lsearch $recent $path] < 0} {
>> +		lappend recent $path
>> +	}
>> +	if {[llength $recent] > 10} {
>> +		set recent [lrange $recent 1 end]
>> +	}
>> +	regsub -all "\[{}\]" $recent {"} recent
>> +	git config --global gui.recentrepos $recent
>> +}
>
> Why treat this as a Tcl list in a single value?  Why not make it
> a true multi-value configuration entry in ~/.gitconfig, like how
> remote.$name.fetch is a multi-value entry?  Does Windows allow
> you to put " in a path name?  Because the above regex will make
> a list of paths that contains " in one of the entries invalid.

I don't think " is allowed. I wasn't able to create a file containing
" in its path. Neither from the explorer nor on the command line.


> I think you also want to have this function return back immediately
> if [lsearch $recent $path] >= 0 as then you don't invoke git-config
> to perform a no-op change in the configuration file.  As you well
> know forking on Windows is a major cost.  We shouldn't run git-config
> just because the user opened a recent repository.
>

The second patch actually runs git config several times to first
remote all multi-value entries and then create them one by one. This
is worse performance than before.

This could be avoided by selectively removing only a single entry.
'git config' could be asked to only remove the entry that was removed
from the tcl list. But 'git config' only accepts regular expression
to do so.

I don't know how to escape a simple string to a corresponding
regular expression that matches only the string but nothing else.

For my problem it would be much easier if 'git config' accepted just
a plain string that must be matched exactly and not a regular  
expression.

I see two solutions:
1) Someone explains me how to convert a string to a regular expression
matching only the input string.

2) "git config" is modified to accept a simple string as its second  
argument.
Maybe we can use implementation in the second patch for now and wait
until "git config" is modified. Note, I'll not start to work on this  
right
away because I want to stay focused on the basic functionality on  
Windows and,
for now, do not care about performance too much.

	Steffen



--Apple-Mail-14-944930427
Content-Transfer-Encoding: quoted-printable
Content-Type: application/octet-stream;
	x-unix-mode=0640;
	name=0001-git-gui-offer-a-list-of-recent-repositories-on-star.patch
Content-Disposition: attachment;
	filename=0001-git-gui-offer-a-list-of-recent-repositories-on-star.patch

=46rom=20a483fdd562d6c44d68a998224e0bbb17933b624a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Steffen=20Prohaska=20<prohaska@zib.de>=0ADate:=20=
Mon,=208=20Oct=202007=2008:25:47=20+0200=0ASubject:=20[PATCH]=20git-gui:=20=
offer=20a=20list=20of=20recent=20repositories=20on=20startup=0A=0AIf=20=
git-gui=20is=20started=20outside=20a=20work=20tree=20the=20repository=0A=
chooser=20will=20offer=20a=20list=20of=20recently=20opend=20=
repositories.=0AClicking=20on=20an=20entry=20directly=20opens=20the=20=
repository.=0A=0AThe=20list=20of=20recently=20opened=20repositories=20is=20=
stored=20in=20the=0Aconfig=20as=20gui.recentrepos.=20If=20the=20list=20=
grows=20beyond=2010=0Aentries=20it=20will=20be=20truncated.=0A=0ANote,=20=
only=20repositories=20that=20are=20opened=20through=20the=0Arepository=20=
chooser=20will=20get=20added=20to=20the=20recent=20list.=0ARepositories=20=
opened=20from=20the=20shell=20will=20not=20yet=20be=20added.=0A=0A=
Signed-off-by:=20Steffen=20Prohaska=20<prohaska@zib.de>=0A---=0A=20=
git-gui/lib/choose_repository.tcl=20|=20=20=2049=20=
+++++++++++++++++++++++++++++++++++++=0A=201=20files=20changed,=2049=20=
insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/git-gui/lib/choose_repository.tcl=20=
b/git-gui/lib/choose_repository.tcl=0Aindex=2016bf67c..4f57572=20100644=0A=
---=20a/git-gui/lib/choose_repository.tcl=0A+++=20=
b/git-gui/lib/choose_repository.tcl=0A@@=20-41,6=20+41,7=20@@=20field=20=
w_body=20=20=20=20=20=20;=20#=20Widget=20holding=20the=20center=20=
content=0A=20field=20w_next=20=20=20=20=20=20;=20#=20Next=20button=0A=20=
field=20o_cons=20=20=20=20=20=20;=20#=20Console=20object=20(if=20active)=0A=
=20field=20w_types=20=20=20=20=20;=20#=20List=20of=20type=20buttons=20in=20=
clone=0A+field=20w_recentlist=20;=20#=20Listbox=20containing=20recent=20=
repositories=0A=20=0A=20field=20action=20=20=20=20=20=20=20=20=20=20new=20=
;=20#=20What=20action=20are=20we=20going=20to=20perform?=0A=20field=20=
done=20=20=20=20=20=20=20=20=20=20=20=20=20=200=20;=20#=20Finished=20=
picking=20the=20repository?=0A@@=20-116,9=20+117,27=20@@=20constructor=20=
pick=20{}=20{=0A=20=09=09-text=20[mc=20"Open=20Existing=20Repository"]=20=
\=0A=20=09=09-variable=20@action=20\=0A=20=09=09-value=20open=0A+=09=
label=20$w_body.space=0A+=09label=20$w_body.recentlabel=20\=0A+=09=09=
-anchor=20w=20\=0A+=09=09-text=20[mc=20"Select=20Recent=20Repository:"]=0A=
+=09set=20w_recentlist=20$w_body.recentlist=0A+=09listbox=20=
$w_recentlist=20\=0A+=09=09-relief=20flat=20\=0A+=09=09-width=2050=20\=0A=
+=09=09-height=2010=20\=0A+=09=09-exportselection=20false=20\=0A+=09=09=
-selectmode=20select=0A+=09foreach=20p=20[_get_recentrepos]=20{=0A+=09=09=
$w_recentlist=20insert=20end=20$p=0A+=09}=0A+=09bind=20$w_recentlist=20=
<<ListboxSelect>>=20[cb=20_open_recent]=0A=20=09pack=20$w_body.new=20=
-anchor=20w=20-fill=20x=0A=20=09pack=20$w_body.clone=20-anchor=20w=20=
-fill=20x=0A=20=09pack=20$w_body.open=20-anchor=20w=20-fill=20x=0A+=09=
pack=20$w_body.space=20-anchor=20w=20-fill=20x=0A+=09pack=20=
$w_body.recentlabel=20-anchor=20w=20-fill=20x=0A+=09pack=20$w_recentlist=20=
-anchor=20w=20-fill=20x=0A=20=09pack=20$w_body=20-fill=20x=20-padx=2010=20=
-pady=2010=0A=20=0A=20=09frame=20$w.buttons=0A@@=20-171,6=20+190,34=20@@=20=
method=20_invoke_next=20{}=20{=0A=20=09}=0A=20}=0A=20=0A+proc=20=
_get_recentrepos=20{}=20{=0A+=09set=20recent=20[list]=0A+=09foreach=20p=20=
[get_config=20gui.recentrepos]=20{=0A+=09=09if=20{[file=20isdirectory=20=
[file=20join=20$p=20.git]]}=20{=0A+=09=09=09lappend=20recent=20$p=0A+=09=09=
}=0A+=09}=0A+=09return=20[lsort=20$recent]=0A+}=0A+=0A+proc=20=
_append_recentrepos=20{path}=20{=0A+=09set=20recent=20[get_config=20=
gui.recentrepos]=0A+=09if=20{[lsearch=20$recent=20$path]=20<=200}=20{=0A=
+=09=09lappend=20recent=20$path=0A+=09}=0A+=09if=20{[llength=20$recent]=20=
>=2010}=20{=0A+=09=09set=20recent=20[lrange=20$recent=201=20end]=0A+=09}=0A=
+=09regsub=20-all=20"\[{}\]"=20$recent=20{"}=20recent=0A+=09git=20config=20=
--global=20gui.recentrepos=20$recent=0A+}=0A+=0A+method=20_open_recent=20=
{}=20{=0A+=09set=20id=20[$w_recentlist=20curselection]=0A+=09set=20=
local_path=20[$w_recentlist=20get=20$id]=0A+=09_do_open2=20$this=0A+}=0A=
+=0A=20method=20_next=20{}=20{=0A=20=09destroy=20$w_body=0A=20=09=
_do_$action=20$this=0A@@=20-893,6=20+940,8=20@@=20method=20_do_open2=20=
{}=20{=0A=20=09=09return=0A=20=09}=0A=20=0A+=09_append_recentrepos=20=
$local_path=0A+=0A=20=09set=20::_gitdir=20.git=0A=20=09set=20::_prefix=20=
{}=0A=20=09set=20done=201=0A--=20=0A1.5.3.mingw.1.99.gdbfb3=0A=0A=

--Apple-Mail-14-944930427
Content-Transfer-Encoding: quoted-printable
Content-Type: application/octet-stream;
	x-unix-mode=0640;
	name=0002-git-gui-handle-list-of-recent-repos-as-multi-config.patch
Content-Disposition: attachment;
	filename=0002-git-gui-handle-list-of-recent-repos-as-multi-config.patch

=46rom=20a9f083e83717eef91ba8842ece4a3ec0824126af=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Steffen=20Prohaska=20<prohaska@zib.de>=0ADate:=20=
Mon,=208=20Oct=202007=2008:14:34=20+0200=0ASubject:=20[PATCH]=20git-gui:=20=
handle=20list=20of=20recent=20repos=20as=20multi=20config=20=
gui.recentrepo=0A=0AInstead=20of=20encoding=20the=20list=20of=20recently=20=
opened=20repositories=0Ain=20a=20single=20config=20line,=20this=20commit=20=
uses=20multiple=20lines=20of=0Agui.recentrepo.=0A=0AAn=20advantage=20is=20=
that=20the=20solution=20makes=20the=20list=20explicit=0Aon=20the=20git=20=
config=20level.=20This=20may=20be=20easier=20to=20understand=0Aif=20the=20=
user=20wants=20to=20look=20at=20the=20configuration.=0A=0AA=20=
disadvantage=20(of=20the=20current=20implementation)=20is=20that=20it=0A=
requires=20more=20git=20config=20calls=20to=20manage=20the=20list.=20=
This=20could=0Abe=20optimized.=20But=20maybe=20not=20required=20because=20=
the=20list=20is=20only=0Aupdated=20on=20opening=20a=20new=20repository,=20=
which=20is=20already=20a=20quite=0Aexpensive=20operation.=0A=0A=
Signed-off-by:=20Steffen=20Prohaska=20<prohaska@zib.de>=0A---=0A=20=
git-gui/git-gui.sh=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=20=
=20=203=20++-=0A=20git-gui/lib/choose_repository.tcl=20|=20=20=2015=20=
+++++++++------=0A=202=20files=20changed,=2011=20insertions(+),=207=20=
deletions(-)=0A=0Adiff=20--git=20a/git-gui/git-gui.sh=20=
b/git-gui/git-gui.sh=0Aindex=203f5927f..8e56294=20100755=0A---=20=
a/git-gui/git-gui.sh=0A+++=20b/git-gui/git-gui.sh=0A@@=20-206,7=20+206,8=20=
@@=20proc=20disable_option=20{option}=20{=0A=20proc=20is_many_config=20=
{name}=20{=0A=20=09switch=20-glob=20--=20$name=20{=0A=20=09=
remote.*.fetch=20-=0A-=09remote.*.push=0A+=09remote.*.push=20-=0A+=09=
gui.recentrepo=0A=20=09=09{return=201}=0A=20=09*=0A=20=09=09{return=200}=0A=
diff=20--git=20a/git-gui/lib/choose_repository.tcl=20=
b/git-gui/lib/choose_repository.tcl=0Aindex=204f57572..9f6926c=20100644=0A=
---=20a/git-gui/lib/choose_repository.tcl=0A+++=20=
b/git-gui/lib/choose_repository.tcl=0A@@=20-192,7=20+192,7=20@@=20method=20=
_invoke_next=20{}=20{=0A=20=0A=20proc=20_get_recentrepos=20{}=20{=0A=20=09=
set=20recent=20[list]=0A-=09foreach=20p=20[get_config=20gui.recentrepos]=20=
{=0A+=09foreach=20p=20[get_config=20gui.recentrepo]=20{=0A=20=09=09if=20=
{[file=20isdirectory=20[file=20join=20$p=20.git]]}=20{=0A=20=09=09=09=
lappend=20recent=20$p=0A=20=09=09}=0A@@=20-201,15=20+201,18=20@@=20proc=20=
_get_recentrepos=20{}=20{=0A=20}=0A=20=0A=20proc=20_append_recentrepos=20=
{path}=20{=0A-=09set=20recent=20[get_config=20gui.recentrepos]=0A-=09if=20=
{[lsearch=20$recent=20$path]=20<=200}=20{=0A-=09=09lappend=20recent=20=
$path=0A+=09set=20recent=20[get_config=20gui.recentrepo]=0A+=09if=20=
{[lsearch=20$recent=20$path]=20>=3D=200}=20{=0A+=09=09return=0A=20=09}=0A=
+=09lappend=20recent=20$path=0A=20=09if=20{[llength=20$recent]=20>=2010}=20=
{=0A=20=09=09set=20recent=20[lrange=20$recent=201=20end]=0A=20=09}=0A-=09=
regsub=20-all=20"\[{}\]"=20$recent=20{"}=20recent=0A-=09git=20config=20=
--global=20gui.recentrepos=20$recent=0A+=09git=20config=20--global=20=
--unset-all=20gui.recentrepo=0A+=09foreach=20p=20$recent=20{=0A+=09=09=
git=20config=20--global=20--add=20gui.recentrepo=20$p=0A+=09}=0A=20}=0A=20=
=0A=20method=20_open_recent=20{}=20{=0A--=20=0A1.5.3.mingw.1.99.gdbfb3=0A=
=0A=

--Apple-Mail-14-944930427
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-14-944930427--
