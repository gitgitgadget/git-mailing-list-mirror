From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Mon, 26 Sep 2011 17:11:49 +0200
Message-ID: <4E809635.9050808@alum.mit.edu>
References: <4E7AF1AE.5030005@alum.mit.edu> <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com> <20110922171340.GA2934@sigill.intra.peff.net> <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu> <20110923193341.GA26820@sigill.intra.peff.net> <4E7D7329.7070800@alum.mit.edu> <20110924061555.GB13974@sigill.intra.peff.net> <4E7DB916.6010606@alum.mit.edu> <20110926110552.GA20796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:12:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Cqm-0000lQ-Pw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab1IZPMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 11:12:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54908 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1IZPMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 11:12:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8QFBnic020075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Sep 2011 17:11:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <20110926110552.GA20796@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182120>

On 09/26/2011 01:05 PM, Jeff King wrote:
> On Sat, Sep 24, 2011 at 01:03:50PM +0200, Michael Haggerty wrote:
>> There are obviously config options that should not be versioned.  These
>> should not be stored in the tree.  (Perhaps they should be stored in
>> another branch, as you suggested.)  But there's no need to prevent
>> people from versioning *any* config options just because they shouldn't
>> version *all* of them.
> 
> Do you have an example of a config option whose old value should be
> respected when looking at an old version? In general, the split between
> attributes and config was meant to split what is tied to a specific
> version, and what should apply to all versions. We may not have followed
> that in all cases, but if so, the right solution may actually be
> migrating the functionality into .gitattributes.

I hadn't realized this point about the split between gitconfig and
gitattributes.  It makes sense.  I'd been thinking that it would be nice
to be able to share changes to the git config the same way that source
code is shared, but you are right that the git config is versioned
differently than the source code.  I can't think of any counterexamples
right now.

>> While we are on the topic of config settings, I have often thought that
>> it would be nice for git's default settings to be set via a
>> well-commented config file, installed along with git, rather than via
>> values compiled into the code.  This file and Documentation/config.txt
>> could be generated from a single source file as part of the build
>> process.
> 
> I think that can be a nice piece of documentation, but there may be some
> complications.  I seem to recall that there may be one or two options
> whose builtin values cannot be replicated via config (i.e., the "unset"
> state means something). But I may be misremembering.

This is more a reason to implement a way to "unset" options than an
argument against storing git's builtin defaults in a gitconfig-formatted
file.

> However, I'm not sure what you mean by "rather than via values compiled
> into the code".  Would you somehow generate code that sets the default
> according to your master file? Would git fail to start if the file is
> missing? Or if a specific config option is missing? How would you track
> that?

I think that git should read its "as-installed" config file at runtime
to maximize the transparency.  If the file is missing then git should
fail, just as it would if some other important part of git were missing
from an install.  The absence of a required config option would be a bug
and might cause git to abort just like any other bug.

I probably shouldn't mention this lest people realize that I'm stupid
and ugly, but...

Subversion installs a file with all of its defaults into your
~/.subversion directory the first time that it runs.  I find this
feature to be very helpful as a source of examples and to learn new
features.  But they do it a bit differently than I am proposing for
git--the file is written to the user's ~/.subversion, and is
subsequently edited by the user.  Because the file lives across
Subversion upgrades, the options in this file are *commented out* to
prevent them causing trouble in the future; i.e., they are for human
consumption only.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
