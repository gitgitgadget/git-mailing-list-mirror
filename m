From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] gitweb: Uniquify usage of subroutine prototypes
Date: Tue, 25 Mar 2008 12:47:34 -0700
Message-ID: <7vlk46lh61.fsf@gitster.siamese.dyndns.org>
References: <1206447114-29349-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeF8I-0002pH-VH
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYCYTru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYCYTru
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:47:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYCYTrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:47:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D2081032;
	Tue, 25 Mar 2008 15:47:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5CCCF1031; Tue, 25 Mar 2008 15:47:41 -0400 (EDT)
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78213>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> The idea is NOT to use subroutine prototypes to create new syntax;
>> prototypes are to be purely informational and optional.

That's unfortunately a grave misconception, isn't it?

For example, can you explain (1) how these three calls behave before
running them, and (2) why these three behave the way they do?

        sub foo       { my ($s, %f) = @_; print "s = $s\n"; }
        sub bar ($;%) { my ($s, %f) = @_; print "s = $s\n"; }

        my @it = ('This is my string');
        my %hash = (rose => 'blue', violet => 'green');

        foo @it, %hash;		# call 1
        bar @it, %hash;		# call 2
	bar $it[0], %hash;	# call 3

By adding ($;%) to an existing function that did not have prototype, you
changed the semantics of the function and:

 (1) it is your responsibility to make sure you did not break existing
     callers when you made such a change, and

 (2) programmers who want to call any existing function in your program
     need to check how the function groks its parameters and make sure
     they do not fall into the same pitfalls as the call sites you had to
     fix in step (1).  They cannot rely on the old fashioned "arguments
     are passed as a flattened list" idiom anymore before checking if you
     have prototypes to the function they want to call.

Prototypes used carelessly tend to force users to do unnecessary things,
because the caller cannot rely on the old fashioned "arguments are passed
as a flattened list" semantics and check how each and every function is
prototyped before making a call.

I am not saying that Perl prototypes is a bad thing.  The point of the
prototype is to change the syntax and semantics so that you can write a
function to which arguments are _not_ passed as a flattend list, and
without them you cannot write something that emulates "push @a, $b, $c".

But you need to be aware of what it does to your callers.
