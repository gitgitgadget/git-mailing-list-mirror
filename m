From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb refactoring
Date: Thu, 22 Jun 2006 17:30:04 +0200
Organization: At home
Message-ID: <e7ed1r$9ve$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jun 22 17:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtR8W-0004Kb-6m
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 17:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWFVPaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Jun 2006 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWFVPaY
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 11:30:24 -0400
Received: from main.gmane.org ([80.91.229.2]:52366 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932475AbWFVPaX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 11:30:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtR8N-0004IJ-Ar
	for git@vger.kernel.org; Thu, 22 Jun 2006 17:30:19 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 17:30:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 17:30:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22345>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Jakub Narebski wrote:
>>
>>> * Refactor generation of navigation bar. There are at least two
>>>=A0=A0=A0implementations=A0of=A0that.=A0With=A0hash=A0dispatch=A0it=A0=
would=A0be=A0easy=A0to
>>>=A0=A0=A0list=A0all=A0possibilities.
>>
>> Actually I think that whole gitweb.cgi needs refactoring, badly.
>> Generation of navigation bar is only one, admittedly worst,=20
>> example of code duplication.
>=20
> Yes.=A0=A0I=A0liked=A0what=A0xmms2=A0folks=A0did=A0to=A0the=A0navbar=A0=
exactly=A0for
> that reason.=A0=A0We=A0would=A0be=A0better=A0off=A0to=A0first=A0clean=
=A0up=A0what=A0we
> currently have before starting to build too much on it.

So lets talk about gitweb refactoring.

Currently gitweb subroutines can be divided into following categories:

1. "Action" subroutines, which do all the work, i.e. they output whole
contents of the page. Currently they are named git_$action, e.g.
git_summary(), git_log(), git_blob(), git_heads(),... , git_blame().=20
The list includes "hidden" actions, namely git_logo(), git_opml(), and
git_project_list(). There is nothing 'git' about those subroutines.
How should they be named? What prefix to use? action_summary(),
write_summary(), output_summary(), out_summary(), gitweb_summary()?

2. Miscelanous "HTML" subroutines, outputting fragments of HTML code, l=
ike
git_header_html, git_footer_html and die_error; or returning fragment o=
f
HTML code, like format_log_line_html. Refactoring should put all the wo=
rk
into such subroutines.

3. Many helper subroutines:=20
  - related o HTML or HTTP: esc_param, esc_html, mimetype_guess_file,=20
    mimetype_guess, git_blob_plain_mimetype, age_class
  - mangling git output: unquote, age_class, age_string, mode_str, file=
_type
  - other helper subroutines: chop_str, date_str, get_file_owner,=20
    validate_input

4. Subroutines which invoke git commands, usually using "-|" LIST magic
output call: git_get_type($hash), git_get_project_config($key) and
git_get_project_config_bool($key), git_get_hash_by_path($base, $path).

Including git_read_tag($hash) and git_read_commit($hash) which fills
%tag/%co object with information from parsing tag/commit.

Unusual in this set git_read_head($project) which sets $ENV{GIT_DIR}
temporarily and git_diff_print($from_id, $from_name, $to_id, $to_name,
$format =3D "html") which does the work for blobdiff and blobdiff_plain=
 using
temporary files (new git probably can do this without need for temporar=
u
files)

5. Subroutines which directly access git repository, sometimes calling
subroutines mentioned above, including: git_read_hash (which needs
refactoring itself I think), git_read_description, git_read_projects,
read_info_ref, git_read_refs (instead of using git-branch or git-tag -l=
,
which also parses information into %ref_item hash).

6* Listed in the sets above are suroutines which parse info into hash o=
r
array of hashes/hashrefs: git_read_tag, git_read_commit, git_read_refs.
Other multi-line output like 'ls-tree' output is parsed and output line=
 by
line.=20


Some of those subroutines probably will find the way to Git.pm. But in =
all
they need to be cleanly separated into classed if possible, and reworke=
d to
do one thing and do it well. Passing parameters instead of relying on
global variables would help porting to mod_perl, for example.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
