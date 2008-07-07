From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn sucks when it should not
Date: Mon, 7 Jul 2008 12:49:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071242180.18205@racer>
References: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness> <20080707094438.GA5964@untitled>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 07 13:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFpGP-00013c-Tg
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 13:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYGGLvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 07:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYGGLvH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 07:51:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:48748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752886AbYGGLvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 07:51:05 -0400
Received: (qmail invoked by alias); 07 Jul 2008 11:51:03 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp017) with SMTP; 07 Jul 2008 13:51:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8y7RKcgb8o7LQMTOzJOrqEdXlPfNBeDsHIDFAoV
	OtvepTZH2uOjeP
X-X-Sender: gene099@racer
In-Reply-To: <20080707094438.GA5964@untitled>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87599>

Hi,

On Mon, 7 Jul 2008, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > [...] a shell script that uses curl to find out what refs are new, and 
> > clones each ref individually, then pushes all the results together 
> > into one repository.
> 
> It might be helpful to publish your script so other people can see/use 
> it.

-- snipsnap --
#!/bin/sh

# This script looks for the config variable svn-manual.url, and if it
# is set, will traverse the url and its subdirectories with curl, and
# install different svn-remotes for all found refs.
#
# It heavily relies on curl being able to screen-scrape the directories,
# in other words, it wants an HTTP on the other side that has directory
# listings enabled.
#
# The quick and dirty heuristics to find out what makes a ref is that
# a ref's subdirectory contains files, while a subdirectory containing
# only subdirectories is supposed to contain refs (or subdirectories
# of refs).

list_contains_files () {
	while test $# -gt 0
	do
		case "$1" in
		*/) ;;
		*) echo "$1";;
		esac
		shift
	done
}

svn_manually_fetch_one_dir () {
	contents="$(curl --silent -k "$1"/ |
		sed -n "s/.*a href=\"\([^\"]*\).*/\1/p" |
		grep -ve '^\.\./$' -e '^http:' -e '^/')"
	test -z "$contents" && return
	test -z "$(list_contains_files $contents)" || {
		test -z "$(git config svn-remote."$2".url)" && {
			git config svn-remote."$2".url "$1" &&
			git config svn-remote."$2".fetch :"$2" ||
			return
		}
		git svn fetch -R "$2"
		return
	}
	for dir in $contents
	do
		dir=${dir%%/}
		svn_manually_fetch_one_dir "$1/$dir" "$2/$dir" || break
	done
}

svn_fetch_semi_manually () {
	url="$(git config svn-manual.url)"
	test -z "$url" && return 1
	svn_manually_fetch_one_dir "$url" refs/remotes
}

svn_fetch_semi_manually || git svn fetch
