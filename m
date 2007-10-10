From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] mergetool: support setting path to tool as config var mergetool.<tool>.path
Date: Wed, 10 Oct 2007 17:44:22 +0200
Message-ID: <FBE79360-4B3A-4C92-B8AA-76989D933009@zib.de>
References: <11919632613176-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710101526060.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tytso@mit.edu, frank@lichtenheld.de, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdiN-0007tZ-2f
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbXJJPnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXJJPnE
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:43:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:45161 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbXJJPnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:43:03 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9AFgpjg026749;
	Wed, 10 Oct 2007 17:42:51 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9AFgo6E002360
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2007 17:42:50 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710101526060.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60510>


On Oct 10, 2007, at 4:33 PM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 9 Oct 2007, Steffen Prohaska wrote:
>
>> This commit adds a mechanism to provide absolute paths to the  
>> external
>> programs called by 'git mergetool'. A path can be specified in the
>> configuation variable mergetool.<tool>.path. The configuration  
>> variable
>> is similar to how we name branches and remotes. It is extensible  
>> if we
>> need to specify more details about a tool.
>
> Okay, let's step back a bit.
>
> What does mergetool do?  It calls different merge helpers, each  
> with its
> own convention how to call it.  For example, tkdiff is called  
> either as
>
> 		tkdiff -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
>
> or as
>
> 		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"
>
> depending if there is a base or not.  Another example is gvimdiff:
>
> 		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
>
> which seems not to care if there is a base.
>
> Now, would it not be much better if we had a way to specify the  
> tool and
> the convention indepentently?  Like
>
> merge.tkdiff.path = C:\bla\blub\wish.exe C:\blub\bleh\tkdiff.tcl
> merge.tkdiff.options = -o %p -- %l %r
> merge.tkdiff.optionsWithBase = -a %b -o %p -- %l %r
>
> and have defaults for the tools we have in git-mergetool.sh _already_?

If you provide a generic mechanism to call an external tool, there's no
need to name the tool. A single mechanism (let's call it external)  
would be
sufficient, like

mergetool.external.path = c:\any\path\merge.exe
mergetool.external.arg2way = %l %r --merge2 --to=%p
mergetool.external.arg3way = %b %l %r --merge3 --to=%p

But this places the burdon on the user to figure out the command line  
syntax
and specify it correctly using git-config. Things like proper  
escaping may
be a hassel.

The solution I'm proposing is more user-friendly. Only the information
that is hard to figure out automatically and is easy to provide by the
user is asked for. The user only needs to tell the path to the  
executable.

git-mergetool 'knows' about the correct command line syntax. There's  
no need
to ask the user. The command line syntax is fixed and know. No option  
here.
"git mergetool" could, for example, know that a certain tool just  
doesn't
support 3-way.

And the code of git-mergetool is also quite easy. The only input  
validation
that is needed is to check if mergetool.<tool>.path points to a valid
executable. If we provide a complex syntax for specifying command line
options we may have to do a lot more of input validation and processing.

I strongly favor my solution of including the command line syntax in
git-mergetool, and only ask the user for the path. I'm not against a  
generic
mechanism to configure any tool. However, I do not plan to implement it.

If someone plans to develop a generic mechanism I see two options:
1) What's explained above.
2) _Define_ the parameters passed to the external command and ask the  
user
    to write a wrapper script to call his tool of choice. Similar to  
what
    GIT_EXTERNAL_DIFF does. Wrapper scripts would go to contrib/.

Both solutions would require more work from the user than needed.

	Steffen
