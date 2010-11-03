From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCHv2 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue, 2 Nov 2010 22:35:03 -0700
Message-ID: <E90779F2-C860-494D-9D54-EEF8A513D43D@sb.org>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org> <1288760740-10075-1-git-send-email-kevin@sb.org> <20101103052837.GB10631@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:35:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDW08-0007l2-0a
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0KCFfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:35:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44327 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab0KCFfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 01:35:05 -0400
Received: by pvb32 with SMTP id 32so81382pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:35:05 -0700 (PDT)
Received: by 10.143.7.6 with SMTP id k6mr3180046wfi.347.1288762505558;
        Tue, 02 Nov 2010 22:35:05 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w23sm854505wfd.9.2010.11.02.22.35.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:35:04 -0700 (PDT)
In-Reply-To: <20101103052837.GB10631@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160581>

On Nov 2, 2010, at 10:28 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> When performing a recursive status or update, any argments with whitespace
>> would be split along that whitespace when passed to the recursive invocation
>> of the update or status command.
>> 
>> This is caused by the special handling that sh provides to the $@ variable.
>> Status and update stored "$@" into a separate variable, and passed that
>> variable to the recursive invocation. Unfortunately, the special handling
>> afforded to $@ isn't given to this new variable, and word-breaking occurs
>> along whitespace boundaries.
>> 
>> We can use $(git rev-parse --sq-quote "$@") to produce a string containing
>> a quoted version of all given args, suitable for passing to eval. We then
>> recurse using something like `eval cmd_status "$orig_args"` instead of the
>> former `cmd_status $orig_args`. This preserves all arguments exactly as
>> given to the initial invocation of the command.
> 
> Probably it is because it is late hear, but I find myself intimidated
> by the block of explanatory text.  Maybe an example like
> 
> 	Environment variables only hold strings, not lists of parameters,
> 	so $orig_args after
> 
> 		orig_args="$@"
> 
> 	fails to remember where each parameter starts and ends, if
> 	some include whitespace.  So
> 
> 		git submodule update \
> 			--reference='/var/lib/common objects.git' \
> 			--recursive
> 
> 	becomes
> 
> 		git submodule update --reference=/var/lib/common \
> 			objects.git --recursive
> 
> 	in the inner repositories.  Use "git rev-parse --sq-quote" to
> 	save parameters in quoted form ready for evaluation by the
> 	shell, avoiding this problem.
> 
> would be simpler?

I agree, yours is simpler. I'll send one final patch with the updated description.

>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -374,7 +374,7 @@ cmd_init()
>> cmd_update()
>> {
>> 	# parse $args after "submodule ... update".
>> -	orig_args="$@"
>> +	orig_args="$(git rev-parse --sq-quote "$@")"
> 
> No quotes are needed around the RHS to an assignment like this.

Hrm, looks like you're right. I was under the impression it was necessary in some
cases when the output of the command included newlines, but a quick test shows
that belief to be wrong.

> Anyway,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-Kevin Ballard
