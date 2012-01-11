From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] gitattribute macro expansion oddity
Date: Wed, 11 Jan 2012 05:37:59 +0100
Message-ID: <4F0D1227.5020509@alum.mit.edu>
References: <20120110070300.GA17086@sigill.intra.peff.net> <7v1ur7bhhe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Henrik?= =?ISO-8859-1?Q?_Grubbstr=F6m?= 
	<grubba@grubba.org>, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:38:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkpxC-0003rL-OR
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab2AKEiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 23:38:12 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60171 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750Ab2AKEiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 23:38:10 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED6D5.dip.t-dialin.net [84.190.214.213])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0B4bxiP007103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Jan 2012 05:38:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7v1ur7bhhe.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188326>

On 01/10/2012 06:22 PM, Junio C Hamano wrote:
> Regardless of this unrelated regression, after looking at what ec775c4
> wanted to do again, I am very much tempted to just revert it.
> 
> It aimed to take these three
> 
>         *       ident
>         foo     mybin
>         bar     mybin ident
> 
> and wanted to omit 'ident' from "foo" when there is this macro definition
> elsewhere:
> 
> 	[attr] mybin binary -ident
> 
> But the real point of the macro was that the users do not have to know
> their internals, iow, if you explicitly specify a pattern that overrides
> the contents of the macro, that explicit pattern should win. When deciding
> the value of "ident" attribute for path "foo", "* ident" is stronger than
> "foo mybin" (the latter of which does not say anything about 'ident'
> explicitly).

I like the simplicity of the rule "apply attributes in the order found
in the .gitattributes files" better than the rule you are proposing,
which seems like it will become more complicated to explain.

For example, it would seem under your rule for the above example that
the "mybin" macro should bestow on file foo the "binary" attribute and
also the "mybin" attribute (given that macros are themselves
attributes), but not "-ident".

You would also have to decide and explain whether a macro that invokes a
macro that sets or clears attribute "foo" is "weaker" than a simple
macro that clears or sets attribute "foo".

I have one real-life use case that would become more difficult with your
rule:

# Marker for textlike files whose EOL characters haven't been
# normalized yet:
[attr]eol-fixme -text !eol

*.cc text eol=lf


# Then later, perhaps in some subdirectory's .gitattributes:
SomeParticularScrewedUpFile.cc eol-fixme


The point of the eol-fixme macro is (1) to prevent git from throwing a
tantrum and (2) to mark the file as needing cleanup sometime in the future.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
