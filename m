From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: fix #patchNN anchors when path_info is enabled
Date: Thu, 17 Mar 2011 20:19:59 +0100
Message-ID: <201103172020.05055.jnareb@gmail.com>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost> <m3hbb258pw.fsf@localhost.localdomain> <7v62rh4ml1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0IkD-000817-AD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab1CQTUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:20:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42246 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1CQTUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:20:19 -0400
Received: by bwz15 with SMTP id 15so2748189bwz.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ei+zXOPus+uVri3mwf6El4chx/DFMyyowDnGaoRJAYI=;
        b=EyHpYZ/LKYYGANUITyA9VnCT++gfdQftqzVOZS0pzM17Td6rzX3jYZe8X1XXm03Wr6
         dKFDmlX0Z45z8qFPuuUVMs97zX3MNtgeQaxutx3v7h/zAL3D/8rixN5WQ0oZbIkZSCxh
         QS2KaPx3l2JqLASbTDaq7MzczoW5+ZGzfoEGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ubrw5OibrnmPel0K8B7MC8dktewmofv6DOHwYz2KelfppeW2KZrCJRdrQctxelEKFO
         2xZ/g6mB2F6577ogP+0byVjRHnoTbPai2msKhbZPp3JWhcrz5FJnNnv2Su6POF3PJo5K
         AMgVZfWhH2yJP5GACZVFtkqfDOY4GD2Tpx7C8=
Received: by 10.204.233.15 with SMTP id jw15mr165983bkb.48.1300389618357;
        Thu, 17 Mar 2011 12:20:18 -0700 (PDT)
Received: from [192.168.1.13] (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id t1sm1599256bkx.19.2011.03.17.12.20.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 12:20:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62rh4ml1.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169259>

On Thu, 17 Mar 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It would be better (less error prone) and easier to use '-replay'
>> option to href(), i.e. write
>>
>>> +				print $cgi->a({-href => href(-replay=>1, -anchor=>"patch$patchno")},
>>> +				              "patch") .
>>
>> or even make it so 'href(-anchor=>"ANCHOR")' implies '-replay => 1'.
> 
> I don't see why "or even" is an improvement, given the following
> implementation.

Well, 

  -href => href(-anchor=>"patch$patchno")

is closer in spirit to

  -href => "#patch$patchno"

that is currently used, and does not work with path_info.
 
> >   @@ -1310,6 +1310,7 @@ sub href {
> >   
> >   	$params{'project'} = $project unless exists $params{'project'};
> >   
> >  -	if ($params{-replay}) {
> >  +	if ($params{-replay} ||
> >  +	    ($params{-anchor} && keys %params == 1)) {
> >   		while (my ($name, $symbol) = each %cgi_param_mapping) {
> >   			if (!exists $params{$name}) {
> >   				$params{$name} = $input_params{$name};
> 
> I don't share your intuition that "anchor" is so special that this part
> will not grow into a long chain of "(I want an implicit replay too) ||".
> 
> Implicitly enabling it in certain obvious cases is perfectly fine, but the
> logic to do so should be in a separate place.  Wouldn't it better to have
> a separate code that sets 'replay' under this and that condition so that
> other people can later add to it at the very beginning of "sub href"?
> 
> Unless we do so, if there are other places that need to change the
> behaviour based on 'replay', they need to duplicate the "implicit" logic.

So you would prefer to have something like this:

 	# implicit -replay
 	if (keys %params == 1 && $params{-anchor}) {
 		# href(-anchor=>"ANCHOR") works like "#ANCHOR", 
 		# correctly if base href is set (for path_info URLs)
 		$params{-replay} = 1;
 	}

set above 'if ($params{-replay}) {'?

-- 
Jakub Narebski
Poland
