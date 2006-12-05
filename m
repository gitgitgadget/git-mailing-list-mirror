X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 16:30:53 +0100
Message-ID: <457590AD.4000806@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <20061205090125.GA2428@cepheus> <45754AFE.1070207@op5.se> <20061205150217.GA5573@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 15:31:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061205150217.GA5573@cepheus>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33349>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrcG2-0008MZ-Uq for gcvg-git@gmane.org; Tue, 05 Dec
 2006 16:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968308AbWLEPa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968309AbWLEPa4
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 10:30:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60213 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968308AbWLEPaz (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 10:30:55 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 8857B6BCBE; Tue,  5 Dec 2006 16:30:53 +0100 (CET)
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>, Andreas Ericsson
 <ae@op5.se>, Martin Waitz <tali@admingilde.org>, Andy Parkins
 <andyparkins@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Uwe Kleine-Koenig wrote:
> Hella Andreas,
> 
> Andreas Ericsson wrote:
>>>> The only problem I'm seeing atm is that the supermodule somehow has to 
>>>> mark whatever commits it's using from the submodule inside the submodule 
>>>> repo so that they effectively become un-prunable, otherwise the 
>>>> supermodule may some day find itself with a history that it can't restore.
>>> One could circumvent that by creating a separate repo for the submodule
>>> at checkout time and pull the needed objects in the supermodule's odb
>>> when commiting the supermodule.  This way prune in the submodule cannot
>>> do any harm, because in it's odb are no objects that are important for
>>> the supermodule.
>> Yes, but then you'd lose history connectivity (I'm assuming you'd only 
>> pull in the tree and blob objects from the submodule, and prefix the 
>> tree-entrys with whatever directory you're storing the submodul in).
> That's the reason for me prefering to pull in the complete commit.
> 
> I don't understand what you mean with "prefix the tree-entrys with
> whatever directory you're storing the submodul in".
> Maybe one of us doesn't understand tree objects correctly.  AFAICT they
> don't store the location where they occur, so there is no need to store
> a prefix.  E.g. 
> 
> 	100644 blob 610bafd79f92c7e546b104d5b22795df1f099723    Makefile
> 	040000 tree 754eadab39642175748bb02155d2959176bcf014    subdir
> 
> So the tree that only contains the Makefile specifing LD_FLAGS has the
> sha1id 754eadab39642175748bb02155d2959176bcf014 independent of being the
> root of my project or a subtree.
> 
> But maybe I misunderstood you?
> 

Nopes. I just didn't think of the fact that subtrees are trees and never 
store any path-info no matter what. So basically the supermodule can 
store all trees of all submodules for each commit adding a new submodule 
revision (which is neat, since "casuals" never have to bother with 
getting all the submodules if they want to see all the code used in any 
particular revision), while we invent the new tree object "subm" that 
points to a commit in the submodule repo. We then teach the tools to 
recognize when the *real* submodule repo is present and just don't check 
out trees from the supermodule odb that lead us to directories where 
submodules reside. Simple and beautiful. Me likes.

*IF* we teach the history viewers about submodules is a different matter 
though. I'm not sure it would make much sense to have simple text-mode 
browsers show the submodule history, although I can imagine qgit and 
gitk wanting to take advantage of their nice side-by-side DAG displaying 
code to show all the repos in parallell, or link between them in some 
point-and-click kind of way.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
