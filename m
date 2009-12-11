From: Gert Palok <gert_p@ut.ee>
Subject: git fetch with GIT_SSH fails with "The remote end hung up 
	unexpectedly"
Date: Fri, 11 Dec 2009 13:57:54 +0200
Message-ID: <c39db29a0912110357t2390e2bcv4c447e320ea379a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 12:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ48f-0006iN-D2
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 12:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZLKL6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 06:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbZLKL6J
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 06:58:09 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:60123 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbZLKL6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 06:58:08 -0500
Received: by fxm21 with SMTP id 21so898234fxm.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 03:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=0Yqrih3HyxX9U1+P1PKRYmusG6/blPAV2G9uzomQvVY=;
        b=GAXyitZPAmsQ96dYj5oWJ7OSmXIcJhjliu22w1XpvaOryN3sjcuL7Jyiw8mlq0bLor
         /BdYNHNci+deD1G7pbV2sjuwO6P36h8ju7U6g2nJrrltgpN/qV6I+diLTVoQ+O4Crqg5
         7R5GNJMYlcxVRdB8CWtAEvABc/bhB9wnznEGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=pEj13CEt3Aub+VOWvnXIadUpo1l/vk/Tuzq4UAs5l0ER2KpyWyMKDF2BJzLBG1zLJp
         vf2B13PANkCgX04R5igxfTWxACZRIDpePWhZUMoycyMud4OCE9S9c5z1dO2JVZGCX/01
         kVx/5RhWiBYP9+v0rvUCpo7ocLR00N4LvVGWA=
Received: by 10.102.160.15 with SMTP id i15mr485382mue.130.1260532694266; Fri, 
	11 Dec 2009 03:58:14 -0800 (PST)
X-Google-Sender-Auth: 4d263d935596cf73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135081>

At my work I have to use an intermediate gateway to ssh to the outer
world. I have set up private-public keys to allow easy connection:
ssh gateway ssh user@outside

Now, I want to fetch from outside repo, so I created a GIT_SSH wrapper:

#! /bin/bash

LOG="/path/to/git-ssh-wrapper.
log"
HOST="$1"
COMMAND="$2"

echo host: $HOST >>"$LOG"
echo command: $COMMAND >>"$LOG"
echo exec: ssh gateway ssh "$HOST" $COMMAND >>"$LOG"
ssh gateway ssh "$HOST" $COMMAND

And ran:
$ GIT_SSH="/path/to/git-ssh-wrapper" git clone ssh://user@outside/path/to/repo
Initialized empty Git repository in /path/to/local-repo/.git/
warning: You appear to have cloned an empty repository.
$ fatal: The remote end hung up unexpectedly

And again just to be sure:
$ GIT_SSH="/path/to/git-ssh-wrapper" git fetch origin
$ fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

Now, the log says:
host: user@outside
command: git-upload-pack '/path/to/repo'
exec: ssh gateway ssh user@outside git-upload-pack '/path/to/repo'

When I ran the command from shell I got:
$ "$GIT_SSH" user@outside "git-upload-pack '/path/to/repo'"
0000

And the connection was kept open (waiting for input, got protocol
error after entering something)

Local environment: Windows Vista 32-bit, cygwin 1.7
Local git version (installed by cygwin): 1.6.4.2
Remote git version: 1.6.4.4

What might be the cause(s)? Have there been compatibility breaking
protocol changes between those version?

--
Gert Palok
