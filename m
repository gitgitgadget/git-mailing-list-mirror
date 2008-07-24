From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 23:30:50 +0200
Message-ID: <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 23:32:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM8Pg-0006l2-N7
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 23:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYGXVaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYGXVaz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 17:30:55 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:61911 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYGXVay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 17:30:54 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id EEC191B0914;
	Thu, 24 Jul 2008 23:30:51 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0807232041570.8986@racer>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89964>

On 23. juli. 2008, at 21.44, Johannes Schindelin wrote:

[...]

> I deem it not, uhm, magical.  By your reasoning there should be a  
> way for
> Git to convert a file to UTF-8 when some entertaining person  
> converted the
> working directory file to ISO-8859-15.

Um, what?  This discussion is about figuring out when Git should mess  
with the line endings a user is trying to commit.  Why are you  
bringing character encodings into it?  Git does not (to my knowledge)  
have any "utf8" setting that converts all files to UTF-8, and  
certainly not one that is enabled by default on Windows.

Being able to mark a file with an "enforce crlf line endings on this  
file" flag is useful _given that Git messes with line endings_, and a  
"do not mess with line endings in this file" flag does not achieve the  
same purpose.  Okay?

If you want my personal opinion on autocrlf, I was happier when Git  
left line endings alone so I didn't have to worry about the files I  
commit being mangled (however reversibly).

I think "autocrlf=input" can make sense on a per-repository basis, but  
I would have it somewhere versioned like .gitattributes, so that (a)  
it is propagated when the repository is cloned, and (b) it is possible  
to take an existing repository with checked-in CRLFs and do a one-time  
conversion that also adds the "autocrlf=input" setting  
to .gitattributes (or wherever the setting ends up going).

I don't use "autocrlf=true", even on Windows, so I don't have any  
opinion on it other than thinking it should be a per-user setting  
rather than per-repository (but with a per-platform default :).  I  
don't see how it could work unless the repository has normalised line  
endings, though.

My background: I have a ton of repositories imported from CVS with a  
sordid mix of CR and CRLF (occasionally in the same file!).  Using  
these repositories with "autocrlf=true" is a pain in the arse since  
CRLFs in the repository cause spurious changes after a clean checkout,  
merge troubles, etc.  The code is supposed to build on Windows as well  
as Unix, so I got bit by this when msysgit changed the default  
autocrlf setting. [1]

My workaround is simply to set autocrlf=false; another solution might  
be to filter-branch all CRLFs out of the repository, but then I'd be  
messing with a lot of history, possibly breaking the files that  
actually need CRLFs, and for no real upside.  No thanks.

Okay, this turned into a longer rant than I intended; what I'm trying  
to say is that I think autocrlf(=true) as it is currently implemented  
is pretty useless, and that a setting that is versioned and cloneable  
would be better.  Phew!
-- 
Eyvind Bernhardsen


Footnote:
1. Your impression that people were rude when "autocrlf=true" was made  
the default on msysgit might be related to the fact that nobody had  
considered what would happen to existing repositories before making  
the change?  Steffen Prohaska wrote in response to one such complaint:

> Unfortunately, existing repositories that contain the wrong line  
> endings
> suffer from the problems you described above.  This can be handled
> either by switching off autocrlf, as you propose, or by cleaning up  
> the
> line endings.

(http://groups.google.com/group/msysgit/browse_thread/thread/978a3435c1cb0c81/70bac514a8b438ef?lnk=gst#70bac514a8b438ef 
)

Steffen went on to propose a patch to make autocrlf a sticky per- 
repository setting, but I think you shot it down.
