From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v4 1/2] gitweb: check given hash before trying to create snapshot
Date: Sun, 13 Sep 2009 17:03:45 +0200
Message-ID: <200909131703.45806.jnareb@gmail.com>
References: <4AAC3833.8060905@mailservices.uwaterloo.ca> <4AAC8521.1060005@mailservices.uwaterloo.ca> <7vy6oj1jug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 17:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmqcV-0000hV-Ai
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbZIMPDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZIMPDs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 11:03:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:10211 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbZIMPDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 11:03:47 -0400
Received: by fg-out-1718.google.com with SMTP id 22so328721fge.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+LfKxzI/QE7Gn4jHN8GXQwei5+H1Kur/hDqq7nfwb8o=;
        b=bbCAjyJiBV8A9c88KApSRRv7lbQn0/In+zMN4RZrkL0fWRCJZ+2bp5E+vxRYU132LM
         diBiPTPwiT58y15VhTOz5pTgWInvPH8dta1u214W8WmUZcu1QkT6f5FITa2yhllIBg5N
         GmJL4d3oQoSDNoxEfxQaswocQhCkpxmLGABOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mm/JGcB/ttLeFSY2Pv/1OX3/j7mL0e+6keR+jkaKJJCCoOi+lwk+Fnnts3jx4g6afQ
         R+edJyN4QfehpiloRpXPSkcKLCgLmLoDRuLS2E6j6PqOxQGgoI5fUQZxcCCYYx62SqGu
         bKqMaFqyB30xK6w7i6gxTUaoGY7SnXi9ivebM=
Received: by 10.86.238.30 with SMTP id l30mr3984858fgh.75.1252854230091;
        Sun, 13 Sep 2009 08:03:50 -0700 (PDT)
Received: from ?192.168.1.13? (abvj176.neoplus.adsl.tpnet.pl [83.8.207.176])
        by mx.google.com with ESMTPS id 12sm3334461fgg.11.2009.09.13.08.03.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 08:03:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy6oj1jug.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128368>

On Sun, 13 Sep 2009, Junio C Hamano wrote:
> Mark Rada <marada@uwaterloo.ca> writes:
>> On 09-09-12 11:30 PM, Junio C Hamano wrote:

>>>> @@ -5196,8 +5202,9 @@ sub git_snapshot {
>>>>  		die_error(403, "Unsupported snapshot format");
>>>>  	}
>>>>  
>>>> -	if (!defined $hash) {
>>>> -		$hash = git_get_head_hash($project);
>>>> +	my $full_hash = git_get_full_hash($project, $hash);
>>>> +	if (!$full_hash) {
>>>> +		die_error(404, 'Hash id was not valid');
>>>>  	}
>>> 
>>> This is in the context of "snapshot", so obviously you care more about
>>> just "such an object exists", don't you?  You also want it to be a
>>> tree-ish.  Try giving it $hash = 'junio-gpg-pub' and see how it breaks.
>>  
>> You have confused me. How is using 'junio-gpg-pub' different from the 
>> second test case that tries to use 'frizzumFrazzum'?
> 
> junio-gpg-pub tag exists in git.git but it tags a blob not a tree.
> 
> 	$ git rev-parse junio-gpg-pub
>         6019c27d966fe3ce8adcc0e9f12078eef96ca6ef
>         $ git archive junio-gpg-pub
>         fatal: not a tree object

So the proper solution with respect to snapshot parameters validation
would be to use

	my $type = git_get_type("$hash^{}");

and check it:
 * if $type is empty or undef (if it is false-ish) then requested object
   does not exist and we return '404 - No such object' (or something like
   that)
 * if $type is 'blob' then we return '400 - Object is not a tree-ish'
   (or something like that)
 * otherwise $type is 'commit' or 'tree'

-- 
Jakub Narebski
Poland
