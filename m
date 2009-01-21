From: Anders Waldenborg <anders@0x63.nu>
Subject: Re: What about allowing multiple hooks?
Date: Wed, 21 Jan 2009 21:35:58 +0100
Message-ID: <4977872E.70901@0x63.nu>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost> <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 21:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPjpp-0002b6-Eg
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 21:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZAUUgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 15:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZAUUgg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 15:36:36 -0500
Received: from main.gmane.org ([80.91.229.2]:33548 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbZAUUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 15:36:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPjoR-0005qc-Sz
	for git@vger.kernel.org; Wed, 21 Jan 2009 20:36:35 +0000
Received: from 81-233-4-40-no34.tbcn.telia.com ([81.233.4.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 20:36:35 +0000
Received: from anders by 81-233-4-40-no34.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 20:36:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81-233-4-40-no34.tbcn.telia.com
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106662>

Junio C Hamano wrote:
> I deliberately omitted support for multiple scripts in core git Porcelains
> to avoid this exact issue.  It is a huge can of worms and it is dubious if
> you can have a coherent and generic enough semantics.
> 
> In the meantime, you can have a single .git/hooks/pre-commit script that
> defines your own convention.  Maybe it uses .git/hooks/pre-commit.d/
> directory, full of scripts, and implements the semantics you want,
> including:
> 
>  (1) the execution order and the naming convention of the scripts (e.g.
>      they all live in pre-commit.d/ directory, and executed in ASCII byte
>      value order of their names);
 >
 >  (2) how their exit status combine together.

I need multiple hooks, so I've done some thinking about this, so I 
thought it may be a good idea to share this here.

I currently use configvalues to specify which hooks to run. For example 
this is how my post-receive looks:

data=$(cat)
git config --get-all hooks.post-receive.hook | while read hook; do
         $hook <<__EOF__
"$data"
__EOF__
done

Now none of my hooks wants to prevent update, so I don't care about 
return status. But it could easily be extended, for example by having 
some indicator per hook that can have the values (are these enough?):

  ignore - pretent that no failure was returned no matter what
  sufficient - if this hook suceeds end result is always sucess
  required - if this hook fails we fail, no more hooks are run

That could be done with the simple configvalue thing as follows:

git config -add hooks.post-receive.hook \
    "sufficient allow-repo-owner-to-do-anything.sh"
git config -add hooks.post-receive.hook \
    "required finegrained-access-control.sh"
git config -add hooks.post-receive.hook \
    "required allow-repo-owner-to-do-anything.sh"
git config -add hooks.post-receive.hook \
    "ignore send-mail.sh"
git config -add hooks.post-receive.hook \
    "ignore send-irc-notification.py"


One problem is that to change order one has to resort to manually 
editing config. So maybe something richer could be used:

[hooks "allow-repo-owner-to-do-anything"]
  cmd = /usr/share/git-hooks/allow-repo-owner-to-do-anything.sh
  enabled = 1
  type = post-receive
  mode = sufficient
  priority = 10

[hooks "mail"]
  cmd = /usr/share/git-hooks/allow-repo-owner-to-do-anything.sh
  enabled = 1
  type = post-receive
  mode = ignore
  priority = 1000

(this would even allow running hooks at same priority simultaneously)

Also then the hook's own config variables fits nicely in same section. 
(note that then each [hooks "x"] will be an instance that could use the 
same script, but different configvars)


  anders
