X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Sun, 03 Dec 2006 18:38:17 -0800
Message-ID: <7virgstmg6.fsf@assigned-by-dhcp.cox.net>
References: <200612040001.13640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 02:38:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612040001.13640.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 4 Dec 2006 00:01:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33160>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr3in-0006ta-Ll for gcvg-git@gmane.org; Mon, 04 Dec
 2006 03:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758959AbWLDCiS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 21:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758965AbWLDCiS
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 21:38:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16567 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1758959AbWLDCiS
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 21:38:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204023818.CNBK7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sun, 3
 Dec 2006 21:38:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uSeT1V0091kojtg0000000; Sun, 03 Dec 2006
 21:38:27 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> The subroutine should return either reference to scalar which means
> "do not process", scalar which means changed available for further
> processing, or void (undef) which means no change. In [PATCH 2/3] we
> will enable returning also list of elements, each of which could be
> reference to scalar or scalar (for example signoff would return three
> element list: opening span element as ref, signoff text as scalar,
> closing span element as ref).

Personally I think that "list of elements" should be in the
first patch to build the foundation.

>   our %committags = (
>   	'sha1' => {
>   		'pattern' => qr/[0-9a-fA-F]{40}/,
>   		'sub' => sub {
>   			my $hash_text = shift;
>   			my $type = git_get_type($hash_text);
>   			if ($type) {
>   				return \$cgi->a({-href => href(action=>$type, hash=>$hash_text),
>   				                -class => "text"}, $hash_text);
>   			}
>   			return undef;
>   		},
>   	},

It might make sense to do a /[0-9a-f]{8,40}/ pattern, and make
sure that the named object exists in the sub (which you already
do).  People often write abbreviated commit object name that has
a high chance of staying unique during the life of the project.

>   	'mantis' => {
>   		'pattern' => qr/(BUG|FEATURE)\(\d+\)/,
>   	'bugzilla' => {
>   		'pattern' => qr/bug\s+\d+/,

This is not wrong per-se but somehow feels funny.  It feels as
if there is a convention that bugzilla bugs are usually spelled
in lowercase while mantis bugs are in uppercase, but I do not
think you are suggesting that.

I do not know how this %committags{} is used per project.  With
a setting like repo.or.cz, it is likely that one instance of
gitweb is serving unrelated projects that have their issue
tracker at different locations using different "committags"
convention.  Is the idea to eventually allow enabling/disabling
elements from the global %committags per repository somehow
(perhaps not just enable/disable but even overriding patterns or
parameters)?

> 3. To not split message into many fragments we concatenate strings
> if possible.

I do not know why "avoiding splits" is needed, if it raises 
issues that you need to ask the list about in a message like
this...
