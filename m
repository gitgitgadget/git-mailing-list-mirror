From: Enrico Weigelt <weigelt@metux.de>
Subject: git-import-tarball
Date: Mon, 30 Aug 2010 08:34:21 +0200
Message-ID: <20100830063421.GA797@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 08:44:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opy68-00080O-KO
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 08:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0H3Gn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 02:43:58 -0400
Received: from caprica.metux.de ([82.165.128.25]:40684 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752543Ab0H3Gn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 02:43:57 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7U6i1so001181
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 08:44:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7U6h14w001137
	for git@vger.kernel.org; Mon, 30 Aug 2010 08:43:01 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7U6YLqR002944
	for git@vger.kernel.org; Mon, 30 Aug 2010 08:34:21 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154769>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi folks,


I'm currently working on an automatic import mechanism for 
various upstreams into repositories of the oss-qm project [1]
and written a little shellscript which imports an existing
tarball as new commit into a git repo.

Maybe someone finds it useful ;-)
(see attachement)

cu
[1] https://sourceforge.net/p/oss-qm/home/
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-import-tarball

#!/bin/bash

help() {
    echo "git-import-tarball <args>"
    echo ""
    echo "Imports an tarball into an existing repository, ontop of given parent commit"
    echo ""
    echo "    --repository=<repository>   Git repository"
    echo "    --tarball=<tarball>         Name of the tarball file"
    echo "    --parent=<parent-ref>       Parent commit to base on"
    echo "    --tag=<tag-name>            Name for the tag to create"
    echo "    --strip-components=<number> String <number> of pathname components before decompression"
    echo ""
    echo "Exit codes:   1    Generic error"
    echo "              2    Syntax error"
    echo ""
}

die() {
    echo "$0: $*"
    exit 1
}

diehelp() {
    echo "$0: $*"
    echo ""
    help
    exit 2
}

callgit() {
    if git --work-tree=${temp_workdir} --git-dir=${param_repository} "$@" ; then
	return 0
    else
	return 1
    fi
}

clean_workdir() {
    rm -Rf "${temp_workdir}"   || die "cannot remove workdir: \"${temp_workdir}\""
    mkdir -p "${temp_workdir}" || die "cannot create workdir: \"${temp_workdir}\""
    return 0
}

## command line parsing
while [ "$1" ]; do
    case "$1" in
	--repository=*)
	    param_repository="${1##--repository=}"
	;;
	--tarball=*)
	    param_tarball="${1##--tarball=}"
	;;
	--parent=*)
	    param_parent="${1##--parent=}"
	;;
	--root-commit)
	    param_root_commit=1
	;;
	--tag=*)
	    param_tag="${1##--tag=}"
	;;
	--strip-components=*)
	    param_strip_components="${1##--strip-components=}"
	    taropt_strip_components="--strip-components=${param_strip_components}"
	;;
	*)
	    echo "$0: unhandled parameter \"$1\""
	    exit 1
	;;
    esac
    shift
done

### parameter checks
[ "${param_root_commit}" ] || [ "$param_parent" ] || diehelp "missing --parent or --root-commit"
[ "${param_tag}" ]                                || diehelp "missing --tag"

### fixup repository path
case "${param_repository}" in
    "")
	diehelp "missing --repository"
    ;;
    ~*)
	param_repository="${HOME}/${param_repository##\~}/.git"
    ;;
    *)
	param_repository="${param_repository}/.git"
    ;;
esac

### fixup the tarball name
case "${param_tarball}" in
    ~*)
	param_tarball="${HOME}/${param_tarball##\~}"
    ;;
    *)
esac

### find out which uncompress command to use
case "${param_tarball}" in
    *.tar.bz2|*.tbz2)
	uncompress_cmd="tar -x -j    -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.gz|*.tgz)
	uncompress_cmd="tar -x -z    -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar)
	uncompress_cmd="tar -x -z    -f  ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.Z|*.tZ)
	uncompress_cmd="tar -x -Z    -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.lzma)
	uncompress_cmd="tar -x -lzma -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.xz)
	uncompress_cmd="tar -x -xz   -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.lzip)
	uncompress_cmd="tar -x -lzip -f ${param_tarball} ${taropt_strip_components}"
    ;;
    *.tar.lzop)
	uncompress_cmd="tar -x -lzop -f ${param_tarball} ${taropt_strip_components}"
    ;;
    "")
	diehelp "missing --tarball option"
    ;;
    *)
	diehelp "unsupported tarball format: \"${param_tarball}\""
    ;;
esac
__tarball_basename=`basename "${parameter_tarball}"`


### render temporary branch name, temporary workdir, etc
temp_branch=`date "+__import_tarball_tmp-%Y-%m-%d-%H-%M-%S"`
temp_workdir=`mktemp`

### create temporary working dir
clean_workdir

### store the previous HEAD pointer
last_head=`callgit symbolic-ref HEAD`

### checkout the parent ref and cleanup again
## fixme: perhaps we should clean out old temporary branches ;-o
if [ "${param_root_commit}" ]; then
    callgit symbolic-ref HEAD "refs/heads/$temp_branch" || die "git-symbolic-ref failed"
else
    callgit checkout -f "${param_parent}" -b "$temp_branch" || die "git-checkout failed"
fi
clean_workdir

### now decompress the workdir
cd ${temp_workdir} || die "cannot chdir to ${temp_workdir}"
$uncompress_cmd || die "uncompress failed: \"$uncompress_cmd\""

### add everything in there to the index
callgit add -A     || die "git add -A failed"

### commit
callgit commit -m "tarball import: ${__tarball_basename}" || die "git-commit failed"

### tag the commit
callgit tag "${param_tag}" || die "git-tag failed"

### final cleanup
callgit symbolic-ref HEAD "$last_head" || die "git-symbolic-ref failed (2)"
callgit branch -D "$temp_branch" || die "git-branch -D for temporary branch failed"
clean_workdir

exit 0

--huq684BweRXVnRxX--
