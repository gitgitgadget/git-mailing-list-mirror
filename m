From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Wed, 25 Feb 2009 15:33:57 +0100
Message-ID: <49A556D5.7020806@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net> <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net> <49A55056.8020504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 15:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcKrJ-0002kp-4A
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 15:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZBYOeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 09:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbZBYOeJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 09:34:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59556 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752868AbZBYOeH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 09:34:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1119E2A61AA;
	Wed, 25 Feb 2009 09:34:06 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 25 Feb 2009 09:34:06 -0500
X-Sasl-enc: afVLkOxVpUJpysQiEMrunubZ4yfts2WCXDgxP294wTNB 1235572445
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F404D12152;
	Wed, 25 Feb 2009 09:34:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090223 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49A55056.8020504@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111460>

Johannes Sixt venit, vidit, dixit 25.02.2009 15:06:
> Michael J Gruber schrieb:
>> @@ -167,6 +167,12 @@ cmd_add()
>>  	;;
>>  	esac
>>  
>> +	# simplify multiple /
>> +	path=$(echo "$path" | sed -e 's|/\+|/|g')
> 
> I think we have so far avoided \+ in sed expressions for portability reasons.

Hmmpf. Is it that new, or gnu specific? I'm always afraid of portability
issues with bash but wasn't aware of sed being an issue as well.

In any case, would 's|\\*|/|g' be better (more portable) then?

>> +
>> +	# resolve /.. (add trailing / for matching /..$)
>> +	path=$(echo "$path/" | sed -e 's|\([^/]*\)/../||g')
> 
> This does not work if there are more than two ../ in a row:
> 
> 	$ echo a/b/c/../../d | sed -e 's|\([^/]*\)/\.\./||g'
> 	a/b/../d

Now you got me ;)
It seems I misunderstood the meaning of 'g'. It's really multiple
matches in one step, not recursively matching multiple times.

> (and make this /\.\./ instead of /../).

Oh yes, you're right, my oversight. Thanks!

I guess this is why test writing and coding should not be done by the
same person...

>> +
>>  	# strip superfluous ./ from path
>>  	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')
> 
> The latter two transformations should be swapped; otherwise you would
> transform foo/./../bar into foo/bar.

Yes! I just checked, and git ls-files get's this right, so g-sm-add
should as well.

> Perhaps it's now time to write this as:
> 
> 	# normalize path
> 	path=$(printf '%s\n' "$path" |
> 		 sed -e '
> 			# simplify multiple /
> 			s|//*|/|g
> 			# strip superfluous ./
> 			s|^\(\./\)*||
> 			s|/\./|/|g
> 			# resolve /..
> 			s|\([^/]*\)/\.\./||g
> 			# strip trailing slashes
> 			s|/*$||
> 		')
> 
> But unless you know how to solve the ../../ case with a sed program, I
> suggest that you keep things simple and take care only of the common cases.
> 
> -- Hannes

Well, how is

echo a/b/c/../../d | sed -e ':start;s|\([^/]*\)/\.\./||g;tstart'
a/d

I meant: how portable is...

Cheers,
Michael
