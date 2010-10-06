From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Wed, 6 Oct 2010 17:17:48 -0500
Message-ID: <20101006221748.GB31818@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002083216.GC29638@burratino>
 <7vocb7yte4.fsf@alter.siamese.dyndns.org>
 <20101006202130.GB2118@burratino>
 <7vhbgzyozx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:21:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cM9-0001T5-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041Ab0JFWUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:20:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52901 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab0JFWUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:20:55 -0400
Received: by qwf7 with SMTP id 7so34395qwf.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9L1zaIbk58YmN0Cy4Pk8H08hc67Hcbn1O1dQwtSvEzk=;
        b=HHtiXnG9Fa9rTTu0oOj29zu8RUER7CsBnILwx6QUr1izHfwiy0kIEpE7ntqPFkO+ZO
         evc7TeYtDvPXjoxoZPOO2wwFf84QRpIy3gaWPeEIX3oXyrV2XLkVcTluXkr0N6y4LaAk
         Ae38j+u7fnrGOz7iiMwBraJrkPZqlQUcMx4Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Btx4tplCJOtr4RkqEAljDKKQgNOBVMl1NOyvadhMDhDnSYawPRa0nIvoibKymHMz8g
         FeCRc2T0MNHcJ90XW9vf0DctFi+BPANVE1Quexk10/UUY2jNxYVTGY7Y+8RBp5yUyQLj
         N9WSc/Y6amh8Fn94/t3P4QUYp/EWhoPM67Hnk=
Received: by 10.224.6.145 with SMTP id 17mr9903940qaz.130.1286403654041;
        Wed, 06 Oct 2010 15:20:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm448798qcr.41.2010.10.06.15.20.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbgzyozx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158333>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> -	while (lock_file_list) {
>> -		if (lock_file_list->owner == me &&
>> -		    lock_file_list->filename[0]) {
>> -			if (lock_file_list->fd >= 0)
>> -				close(lock_file_list->fd);
>> -			unlink_or_warn(lock_file_list->filename);
>> -		}
>> -		lock_file_list = lock_file_list->next;
>> +	while (p) {
>> +		if (p->owner == me &&
>> +		    p->filename[0]) {
>> +			if (p->fd >= 0)
>> +				close(p->fd);
>> +			unlink_or_warn(p->filename);
>> +		}
>> +		p = lock_file_list->next;
>> 	}
>
> Heh, shouldn't the last one assign from p->next?

Yes.  And I also should have mentioned: this is untested.
