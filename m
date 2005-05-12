From: David Greaves <david@dgreaves.com>
Subject: [PATCH] Ignore file filter
Date: Thu, 12 May 2005 22:30:32 +0100
Message-ID: <4283CAF8.3050304@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060207020308020405020809"
X-From: git-owner@vger.kernel.org Thu May 12 23:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLBE-0007TL-Qa
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVELVcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVELVbs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:31:48 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:57271 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262136AbVELVar (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 17:30:47 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 01F1CE6D9E; Thu, 12 May 2005 22:29:23 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13791-11; Thu, 12 May 2005 22:29:22 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.202.84])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5479DE6E03; Thu, 12 May 2005 22:29:21 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWLGK-0004yz-F6; Thu, 12 May 2005 22:30:32 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207020308020405020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Petr

This is an inline filter that introduces the concept of .git/ignore
It is intended to be used within the cogito scripts like the other cg-X*
files.


Signed-off-by: David Greaves <david@dgreaves.com>

-- 


--------------060207020308020405020809
Content-Type: text/plain;
 name="cg-Xignore"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-Xignore"

#!/usr/bin/env bash
#
# Takes a list of files on stdin and only passes valid ones agording to .git/ignore
# Copyright (c) David Greaves, 2005
#
# This filter implements cogito ignore rules and should typically be used in find pipelines
#
# Synopsis
# cg-Xignore [-debug] [-f] [-h] [-d] < file-list >useful-file-list
#
# Options
# -debug::
#     produce helpful debug output
#
# -q::
#     don't say what paths are ignored
#
# -f::
#     passes files
#
# -d::
#     passes directories
#
# -h::
#     passes symbolic links
#
# The default is to pass all file types that are not ignored.
#
# Note that the .git/ignore file contains multiple expressions, 1 per line
# Lines beginning with a '#' are ignored (allowing comments)
# These are 'bash regular expressions' not glob patterns
# This allows ignore rules to take the directory into account
# Suggested contents:
#   # bash regexps (not globs)
#   ^\.[^/]
#   /\.
#   /$
#   .*\.o$


# This doesn't allow the -h which is the [ arg for symlinks...
#. ${COGITO_LIB}cg-Xlib
_git=${GIT_DIR:-.git}

IGNORE_FILE="$_git/ignore"

if [ "$1" = "-0" ]; then
    # doesn't work :(
    zerosep=$'-d "\0"'
    shift
fi

# Defaults
pass_files=0
pass_dirs=0
pass_links=0
pass_all=1
while [ $# -gt 0 ]; do
    case $1 in
	"-f")
	    pass_all=0
	    pass_files=1
	    ;;
	"-d")
	    pass_all=0
	    pass_dirs=1
	    ;;
	"-h")
	    pass_all=0
	    pass_links=1
	    ;;
	"-q")
	    quiet=1
	    ;;
	"-debug")
	    debug=1
	    ;;
	esac
    shift
done

# save stderr
exec 5>&2
if [ $quiet ]; then
    # turn off noise
    exec 2>&-
fi

if [ $debug ]; then
    exec 4>&5
else
    exec 4>/dev/null
fi


# Strip out the common leading ./ allowing "find ."
sed 's:^./::' | \
while read $zerosep file; do
    echo "consider file: $file" >&4
    ignore=0
    if [ -f $IGNORE_FILE ]; then
	exec 3<$IGNORE_FILE
	while read -r -u3 patt ; do
	    if [[ $patt =~ "^\w*#" ]]; then
		continue
	    fi
	    echo "consider pattern: $patt" >&4
	    if [[ $file =~ $patt ]]; then
		ignore=1
		echo "Ignoring $file because of $patt" >&2
		break
	    fi
	done
    fi
    echo "passing file: $file" >&4
    
    if [ $ignore != "1" \
	-a \( $pass_all -eq 1 \
	   -o \( $pass_files -eq 1 -a -f $file \) \
	   -o \( $pass_dirs  -eq 1 -a -d $file \) \
	   -o \( $pass_links -eq 1 -a -h $file \) \
	   \) \
	]; then
	echo $file
    fi
done

--------------060207020308020405020809--
