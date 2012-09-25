From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git blame
Date: Tue, 25 Sep 2012 16:05:40 -0700
Message-ID: <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
 <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <xmeng@cs.wisc.edu>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGeCP-0006Pl-U2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab2IYXFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 19:05:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab2IYXFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 19:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F378D9B50;
	Tue, 25 Sep 2012 19:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/SJMgfkmrPO7dZc44r5og25j9MI=; b=Mfx9g3
	xtXBxHQujj23bux6cbTfgmiDavaKKcDRqJqRcl8g2SrO2O87jSQjT2LyvyPRdqV0
	SqezvrTzFNWCsmsQJDm3cXJbdjNOy1momYICet0aPINOvEeXrcu0i6WJJvvOCJzp
	A6eYPw/zi6lvcF1V8KWA8zTW3mKVDPirIrKjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e5suIWuceUbrSYp67yV3CV4GFxApVvJs
	MNqeGnPzO/UkDs5HLScrDXQVCi4SAspkMwetaQOi69rdZkJd6Nn3KX/q8v31jxNi
	diAo117p4TifiZlodB4K/NxgKFQwaQnXbMp000x0I9wkO/5iqRRdTeb+1HevHQig
	T55emXrvZD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4D69B4F;
	Tue, 25 Sep 2012 19:05:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DC3B9B4D; Tue, 25 Sep 2012
 19:05:42 -0400 (EDT)
In-Reply-To: <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley> (Philip Oakley's
 message of "Tue, 25 Sep 2012 23:19:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87997FAA-0765-11E2-8AAC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206382>

"Philip Oakley" <philipoakley@iee.org> writes:

>> To get ground truth of authorship for each line, I start with
>> git-blame.
>> But later I find this is not sufficient because the last commit may
>> only
>> add comments or may only change a small part of the line, so that I
>> shouldn't attribute the line of code to the last author.
>
> I would suggest there is:
> - White space adjustment
> - Comment or documentation (assumes you can parse the 'code' to decide
> that it isn't executable code)
> - word changes within expressions
> - complete replacement of line (whole statement?)

You are being generous by listing easier cases ;-) I'd add a couple
more that are more problematic if your approach does not consider
semantics.

 - A function gained a new parameter, to which pretty much everbody
   passes the same default value.

	-void fn(int a, int b, int c)
	+void fn(int a, int b, int c, int d)
	 {
	+	if (d) {
	+		...
	+		return;
	+	}
		...
	 }

         void frotz(void)
	 {
		...
        -	fn(a, b, c);
        +	fn(a, b, c, 0);
        	...
        -	fn(a, b, d);
        +	fn(a, b, d, 1);
        	...

   The same commit that changed the above call site must have
   changed the definition of function "fn" and defined what the new
   fourth parameter means.  It is likely that, when the default
   value most everybody passes (perhaps "0") is given, "fn" does
   what it used to do, and a different value may trigger a new
   behaviour of "fn".  It could be argued that the former call
   should not be blamed for this commit, while the latter callsite
   should.

 - A variable was renamed, and the meaning of a line suddenly
   changed, even though the text of that line did not change at all.

	 static int foo;
         ...
        -int xyzzy(int foo)
	+int xyzzy(int bar)
	 {
		... some complex computation that
                ... involves foo and bar, resulting in
                ... updating of foo comes here ...
		return foo * 2;
 	 }

   Whom to blame the behaviour of (i.e. returned value from) the
   function?  The "return foo * 2" never changed with this patch,
   but the patch _is_ responsible for changing the behaviour.

   As the OP is interested in tracking the origin of the _binary_,
   this case is even more interesting, as the generated machine code
   to compute the foo * 2 would likely to be very different before
   and after the patch.
