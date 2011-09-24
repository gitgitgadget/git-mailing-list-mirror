From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Sat, 24 Sep 2011 13:03:50 +0200
Message-ID: <4E7DB916.6010606@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu> <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com> <20110922171340.GA2934@sigill.intra.peff.net> <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu> <20110923193341.GA26820@sigill.intra.peff.net> <4E7D7329.7070800@alum.mit.edu> <20110924061555.GB13974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 24 13:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Q1p-0003x5-IN
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 13:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab1IXLEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 07:04:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38103 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1IXLEA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 07:04:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEB3E5.dip.t-dialin.net [84.190.179.229])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8OB3pBt003938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Sep 2011 13:03:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <20110924061555.GB13974@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182026>

On 09/24/2011 08:15 AM, Jeff King wrote:
> On Sat, Sep 24, 2011 at 08:05:29AM +0200, Michael Haggerty wrote:
>> This could be implemented by having a single local config option that
>> enables the use of an in-tree .gitconfig file:
>>
>>     git config core.useTreeConfig true
>>
>> (or whatever the correct naming convention would be).  This option would
>> default to false, so the in-tree config would only occur following an
>> affirmative decision by the cloner.
> 
> But once you've verified that the config looks OK and turned this option
> on, how do you protect yourself from malicious config entering the repo
> through a fetch?

For most software projects, the user does

    git pull
    make

daily.  There is nothing that a nasty .gitconfig can do that can't be
done more easily by a nasty Makefile (or anything else in the build
process).  The moment I pull from Junio's repository and run a build
without having personally done a full code review first, I've given
Junio complete pownership of my account.  For projects in which I invest
such trust, "core.useTreeConfig=true" would be a convenience that does
not appreciably increase my risk.

>> If finer granularity is required, config options could be classified
>> into "security-relevant" and "non-security-relevant" options, where the
>> former group basically includes anything that can cause arbitrary code
>> to be executed.  Then there could be a "core.useTreeConfig = safeonly"
>> option to allow only the harmless options.
> 
> This is the "can of worms" I referred to earlier. You have to start
> classifying each option.

It is not a "can of worms" in the sense of insoluble.  It is only a lot
of work.  We could start today by setting a default that all config
options are dangerous, incrementally opening up options as they are vetted.

>> I think the priority of config options (highest to lowest) should be
>>
>>        $GIT_DIR/config
>>        in-tree .gitconfig
>>        ~/.gitconfig
>>        $(prefix)/etc/gitconfig
> 
> One catch with any precedence scheme is that there are certain config
> constructs that cannot be overridden.

Good point, and good suggestion to allow config constructs to be cleared.

>> Of course, just like for attributes, it would have to be decided which
>> version of the .gitconfig to use in which situations.
> 
> I'm not sure it makes sense to have it in the tree at all. For
> attributes it makes sense, because you are annotating a path at a
> _specific_ revision. But config is often much more meta- than that.
> Take textconv for an example. The gitattributes say "foo.pdf should use
> the 'pdf' diff driver". That makes sense to go in a revision. But the
> config will say "pdf files can be converted to text using
> /usr/bin/pdftotext". That is not something that is tied to the revision
> at all, and should exist outside of any revision. I.e., whether I am
> doing a "git show" on the HEAD, or on some ancient commit, I would want
> to use the same value, not whatever tool I used to convert PDFs years
> ago.

There are obviously config options that should not be versioned.  These
should not be stored in the tree.  (Perhaps they should be stored in
another branch, as you suggested.)  But there's no need to prevent
people from versioning *any* config options just because they shouldn't
version *all* of them.

I think that your "config-file includes" proposal would make all of this
possible or nearly possible, but I'll have to read your proposal more
carefully before I can comment.


While we are on the topic of config settings, I have often thought that
it would be nice for git's default settings to be set via a
well-commented config file, installed along with git, rather than via
values compiled into the code.  This file and Documentation/config.txt
could be generated from a single source file as part of the build
process.  Advantages:

1. It would give a single place for people to see exactly what defaults
are being applied, and a good starting point for seeing what can be
changed locally.

2. It would ensure that the defaults listed in the documentation always
match those being used, and prevent different default values from being
used in different places in the code.

3. It would make it easy to discover what default values have changed
between two git versions (i.e., what new knobs there are to turn).

4. It would make it easy for packagers to tweak the built-in defaults,
and would make it obvious what defaults packagers had changed.  (Of
course packagers can already just include an /etc/gitconfig, but it
would be better to reserve that file for sitewide changes).

The priority would obviously be:

        $GIT_DIR/config
        in-tree .gitconfig
        ~/.gitconfig
        $(prefix)/etc/gitconfig
        git's installed defaults

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
