X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 5 Dec 2006 16:02:17 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061205150217.GA5573@cepheus>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <20061205090125.GA2428@cepheus> <45754AFE.1070207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 15:02:55 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Andreas Ericsson <ae@op5.se>, Martin Waitz <tali@admingilde.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45754AFE.1070207@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33348>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grboo-0003Z5-4L for gcvg-git@gmane.org; Tue, 05 Dec
 2006 16:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968263AbWLEPCi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760206AbWLEPCi
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 10:02:38 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55378 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1760193AbWLEPCh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5
 Dec 2006 10:02:37 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60) (envelope-from
 <zeisberg@informatik.uni-freiburg.de>) id 1GrboZ-00063m-RQ; Tue, 05 Dec 2006
 16:02:36 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id
 kB5F2X6W018096; Tue, 5 Dec 2006 16:02:33 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.6/8.12.11/Submit) id kB5F2XUr018095; Tue, 5 Dec 2006 16:02:33 +0100
 (MET)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hella Andreas,

Andreas Ericsson wrote:
> >>The only problem I'm seeing atm is that the supermodule somehow has to 
> >>mark whatever commits it's using from the submodule inside the submodule 
> >>repo so that they effectively become un-prunable, otherwise the 
> >>supermodule may some day find itself with a history that it can't restore.
> >One could circumvent that by creating a separate repo for the submodule
> >at checkout time and pull the needed objects in the supermodule's odb
> >when commiting the supermodule.  This way prune in the submodule cannot
> >do any harm, because in it's odb are no objects that are important for
> >the supermodule.
> 
> Yes, but then you'd lose history connectivity (I'm assuming you'd only 
> pull in the tree and blob objects from the submodule, and prefix the 
> tree-entrys with whatever directory you're storing the submodul in).
That's the reason for me prefering to pull in the complete commit.

I don't understand what you mean with "prefix the tree-entrys with
whatever directory you're storing the submodul in".
Maybe one of us doesn't understand tree objects correctly.  AFAICT they
don't store the location where they occur, so there is no need to store
a prefix.  E.g. 

	zeisberg@cepheus:/tmp$ mkdir test-repo
	zeisberg@cepheus:/tmp$ cd test-repo/
	zeisberg@cepheus:/tmp/test-repo$ git-init-db 
	defaulting to local storage area
	zeisberg@cepheus:/tmp/test-repo$ echo LD_FLAGS=-ltest > Makefile
	zeisberg@cepheus:/tmp/test-repo$ git add Makefile
	zeisberg@cepheus:/tmp/test-repo$ git commit -m 'test1'
	Committing initial tree 754eadab39642175748bb02155d2959176bcf014
	zeisberg@cepheus:/tmp/test-repo$ mkdir subdir
	zeisberg@cepheus:/tmp/test-repo$ cp Makefile subdir/
	zeisberg@cepheus:/tmp/test-repo$ git add subdir/
	zeisberg@cepheus:/tmp/test-repo$ git commit -m 'test2'
	zeisberg@cepheus:/tmp/test-repo$ git ls-tree HEAD
	100644 blob 610bafd79f92c7e546b104d5b22795df1f099723    Makefile
	040000 tree 754eadab39642175748bb02155d2959176bcf014    subdir

So the tree that only contains the Makefile specifing LD_FLAGS has the
sha1id 754eadab39642175748bb02155d2959176bcf014 independent of being the
root of my project or a subtree.

But maybe I misunderstood you?

Best regards
Uwe

-- 
Uwe Kleine-Koenig

If a lawyer and an IRS agent were both drowning, and you could only save
