From: Bosko Ivanisevic <bosko.ivanisevic@gmail.com>
Subject: Gforge's cvssh.pl script and git
Date: Wed, 18 Feb 2009 10:24:18 +0100
Message-ID: <2c0671440902180124v50570270gc40b745d4a8b1245@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 10:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZigf-00038y-Vi
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 10:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZBRJYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZBRJYW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 04:24:22 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:65044 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZBRJYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 04:24:20 -0500
Received: by bwz5 with SMTP id 5so5137681bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=nTsLnvs+AQSBUJNFrNh6dLUMJ4UPnIa7+RGNHAJY17U=;
        b=xbvr0cn4Jdpw+Kxi4IrzWZ4W8M034KHy3I2L/NLi9YU5ua5i02UR/EwnnUk1qaN6py
         WzdDa6NTXZLIaYiMPnb54wmetvknW2P887OJtndCaWHfZNFQWroipXUqPxWRQZRS6ZY9
         j98SqDMpdSf7Zs5aJblmknlG6MwGc/BjsZ2Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=G9L8QICs5xd9xmP+XCew5c0LmrwtebpqglfXFV+25kgrDbA/R1sxIPBLAOEd3f/SXL
         ul0R2n0S4fXj3E7ctXeF9nMEp6WXo47X8768gKwHes0c3K3O8UEUEF0CWkiGlQQEB2Fe
         reNXMouNna2RWBrhLb3Mr03EYVfpogq3ZE8ts=
Received: by 10.181.60.13 with SMTP id n13mr1484434bkk.39.1234949058575; Wed, 
	18 Feb 2009 01:24:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110518>

In the company I'm working someone has restricted access to all users
to only use cvs via cvssh.pl script (source at the end of message)
taken from gforge. This script is set as a shell for all users. Now I
would like to change it so I can run git too. I've tried by adding
'git', 'git-upload-pack', 'git-receive-pack' and 'git-shell' in the
array @allowed_commands. After that if I try to clone existing
repository with:

git clone ssh://testuser@server_name/tmp/test.git

I get following error:

fatal: ''/tmp/test.git'': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

I first thought that testuser doesn't have permissions to read
directory /tmp/test.git so I changed mode and gave r+w permissions
recursively on that folder, but result was same.

There is no way I can avoid this perl script (company policy) but I
can change it. Problem is that I do not know Perl so much and I do not
know what git is exactly doing behind the scene when it is run via
ssh. Can anyone tell me why this perl script doesn't allow git to run
properly and what has to be changed to enable git?

#! /usr/bin/perl -w
#
# $Id: cvssh.pl 3987 2005-02-26 22:59:11Z tperdue $
#
# "Shell" for a restricted account, limiting the available commands
# Roland Mas, debian-sf (Sourceforge for Debian)
#
# Inspired from the grap.c file in Sourceforge 2.5

use strict ;
use vars qw/ @allowed_options @allowed_commands $errmsg @cmd / ;
use subs qw/ &reject / ;
no locale ;

@allowed_options = ('-c', '-e') ;
@allowed_commands = ('cvs') ;

# Clean up our environment
delete @ENV{qw(IFS CDPATH ENV BASH_ENV PATH)};

@cmd = split (/ +/, $ENV{SSH_CLIENT});

if (scalar (grep {/192.168.0/}  @cmd) == 0) {
    $errmsg = "Client address not allowed." ;
    &reject ;
}

if ($#ARGV != 1) {
    if ($#ARGV < 1) {
        $errmsg = "Not enough arguments." ;
    } else {
        $errmsg = "Too many arguments." ;
    }
    &reject ;
}


if (scalar (grep  { $_ eq $ARGV[0] }  @allowed_options) == 0) {
    $errmsg = "Option not allowed." ;
    &reject ;
}

@cmd = split (/ +/, $ARGV[1]) ;


if (scalar (grep { $_ eq $cmd[0] }  @allowed_commands) == 0) {
    $errmsg = "Command not allowed." ;
    &reject ;
}

exec @cmd ;

sub reject {
    print "This is a restricted account.\n" .
        "You cannot execute anything here.\n" .
        # $errmsg . "\n" .
        "Goodbye.\n" ;
    exit 1 ;
}
