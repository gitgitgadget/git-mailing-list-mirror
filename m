From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [ANNOUNCE] A pre-receive hook to intelligently block binary data
Date: Fri, 31 Oct 2014 20:25:41 +0100
Message-ID: <CACBZZX64ofaQSoOMhQcjx+ED2LOpdDVZJ_5TSjotuBv4m+Fb5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:26:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkHpo-0005i2-1i
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 20:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbaJaT0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 15:26:03 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55520 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbaJaT0C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 15:26:02 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp4so6488515obc.3
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=VSQNVDJV/+sEejjONO29uLBGiQsHw9s7SjHFog+Xc1E=;
        b=I4za40dEB8085IAamIwB6zmovV4QZ5PKE/BwMw9e/ducKnxpZYXhU1tYJuC6j3NasX
         mMWoK5E4erxra7P+oHU5gF2UKKR+4GmWERhZ9/zgDqOXt32l78n8OqKmA8CawE+DAXqq
         Xgp3ZO+tlLUGLvT7YijBDi0khFW8vEKD+rQZsvjiFr7UKvo/tdOzA1PvRDCWp2jIxaUb
         KygJESY/iQn8NU+TnBiN8Vv0HViXeFSWnXP4gl06CTMKrQtuTqRPSgG3apzXxkjceZEm
         jhZUPxUEMZDCyK+hyjAqLH1yMyF95Vi4pXeaL+n5ORY3MgKk+paQSs08HPZ9s0cZJQJB
         5isw==
X-Received: by 10.182.33.67 with SMTP id p3mr22168722obi.15.1414783561158;
 Fri, 31 Oct 2014 12:26:01 -0700 (PDT)
Received: by 10.76.171.166 with HTTP; Fri, 31 Oct 2014 12:25:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After searching around a bit I couldn't find a stand-alone Git hook
that would intelligently block binary data pushes so I wrote my own:
https://github.com/avar/pre-receive-reject-binaries

Main features:

 * Quota per-commit for how much binary data is OK
 * Ability to optionally allow users to override binary pushes by
including a notice in their commit messages
 * Doesn't disallow removing existing binary data, or renaming
existing binary files
 * Will block commits that include references to existing binary blobs though
 * Spots cases where a push is pushing commits that add and then
remove binary blobs (i.e. counts net additions)
 * Has hookable support for logging by piping its output to external
commands when it runs or when it rejects/unblocks a binary push. I'm
using this for logging its output to a logfile, and to send E-Mails
when it blocks/is unblocked.
* Only requires a stock perl install, should run on any *nix-like OS
out of the box
* Should be relatively fast compared to some other similar solutions
I've seen, i.e. it parses the output of one "git-log --stat" command
for the entire push, and doesn't e.g. do a "git show" for each commit
being pushed.

One general note about git-log output: I was disappointed to see that
there was no easily parsable "git log" output that showed you how much
binary files increased in size, --numstat will just show "-" for
binary files, and it's non-trivial to parse the "--stat" output. It's
meant for human consumption and will sometimes include variations in
how much whitespace is inserted.
