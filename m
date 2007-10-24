From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/9] Make git-svn fetch ~1.7x faster
Date: Wed, 24 Oct 2007 13:43:51 +1300
Message-ID: <471E9547.2030100@vilain.net>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <20071023060812.GA30978@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, aroben@apple.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkUM0-0005U9-Ul
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 02:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXJXAoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 20:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXJXAoA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 20:44:00 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48619 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbXJXAn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 20:43:59 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 18E3F21CFEA; Wed, 24 Oct 2007 13:43:57 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 90D8D21CF66;
	Wed, 24 Oct 2007 13:43:53 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20071023060812.GA30978@glandium.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62177>

Mike Hommey wrote:
> On Mon, Oct 22, 2007 at 10:46:28PM -0700, Adam Roben wrote:
>> This patch series makes git-svn fetch about 1.7x faster by reducing the number
>> of forks/execs that occur for each file retrieved from Subversion. To do so, a
>> few new options are added to git-cat-file and git-hash-object to allow
>> continuous input on stdin and continuous output on stdout, so that one instance
>> of each of these commands can be kept running for the duration of the fetch.
> 
> You don't need to do this to avoid forks. Just use git-fast-import
> instead.

git-fast-import only covers the hash-object side of things, not cat-file.

git-fast-import does not currently suit 'gradual deployment' for
converters such as git-svn, because it;

  - returns object IDs at the end, when you checkpoint.

    This could be 'fixed' by allowing a marks log file instead of or in
    addition to the current behaviour, though if the exporter is
    continually waiting for the tokens rather than using marks, it will
    slow it down.

  - you can't use plumbing commands, such as rev-parse, cat-file, etc on
    objects which have not been checkpointed yet.

  - can't just stream a file of unknown length to it as you can to
    hash-object

These are the design trade-offs of using fast-import.  Using
fast-import, you are creating a 'transaction' area which uses user
sequences instead of (git)database-issued identifiers.  And this
transaction is isolated from the other concurrent users of the object
database.  However the interface does not have the full git CLI
available to it, so unlike a regular database transaction, you end up
having to care.

Rewriting the importer so as to correctly deal with these problems is
quite challenging, and for slow import sources such as Subversion, of
limited merit.

Sam.
