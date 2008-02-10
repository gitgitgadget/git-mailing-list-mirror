From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Alternative approach to the git config NULL value checking
 patches..
Date: Sun, 10 Feb 2008 15:50:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101541380.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org> <7vbq6oe98y.fsf@gitster.siamese.dyndns.org> <7v7ihce8ex.fsf@gitster.siamese.dyndns.org>
 <20080210232920.GH5129@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLyb-000627-46
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYBJXwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYBJXwN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:52:13 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37911 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753494AbYBJXwM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 18:52:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANov57019579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 15:50:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANouro019873;
	Sun, 10 Feb 2008 15:50:57 -0800
In-Reply-To: <20080210232920.GH5129@artemis.madism.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73440>



On Mon, 11 Feb 2008, Pierre Habouzit wrote:
>
> > Having said all that, it might be an option to change your patch
> > slightly to say:
> > 
> > 	const char config_true[] = "true";
> 
> I was about to suggest the same, and testing against "config_true" just
> becomes an optimization, but isn't required. Seems an appropriate hack
> to me.

Well, I had the thing actually written that way, but it breaks some of the 
test-suite. Whether the test-suite actually *should* test for what it 
tests for is obviously debatable, but it does. It does test that when you 
do

	git config --get novalue.variable

you are expected to get an empty result. Is that good? Probably not. But 
it's what you get traditionally, and it's what the tests actually test for 
(t/t1300-repo-config.sh in case you care).

But yes, I actually think it might be an improvement and have that thing 
return "true" (which is what happens if you make the 'config_true' array 
contain that string). And that allows removal of one test from the 
"git_config_bool()" function, but on the other hand, it does result in 
some strange stuff too..

In particular, *if* somebody just takes a string blindly and uses

	result = xstrdup(value);

then with my patch it would then use an empty string for whatever it 
happened to pick. So having something like

	[user]
		name

will mean that your name is empty (which will actually trigger an error if 
you try to commit).

In contrast, if you do that 'config_true[] = "true"' thing, then that 
config file entry will make your name be the string "true", which is just 
_odd_.

So I think an empty config_true actually has a nicer and more easily 
explainable failure case. It causes empty strings when mis-used, not 
arbitrary and strange "true" strings.

Whatever. 

		Linus
