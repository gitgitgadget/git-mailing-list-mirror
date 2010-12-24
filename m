From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Fri, 24 Dec 2010 09:53:06 -0700
Message-ID: <4D14CFF2.9050705@workspacewhiz.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com> <7vfwto2ytb.fsf@alter.siamese.dyndns.org> <4D13DCDD.3050300@workspacewhiz.com> <AANLkTikaBfVw-4eD9qeGSdM5xKxq-gJ-3oAe4B2qt4od@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 17:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWAtK-0000Bj-Ui
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 17:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab0LXQxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 11:53:13 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:45237 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0LXQxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 11:53:12 -0500
Received: (qmail 1663 invoked by uid 399); 24 Dec 2010 09:53:07 -0700
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Dec 2010 09:53:07 -0700
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTikaBfVw-4eD9qeGSdM5xKxq-gJ-3oAe4B2qt4od@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164162>

----- Original Message -----
From: Nguyen Thai Ngoc Duy
Date: 12/23/2010 6:39 PM
> If you have not known already, path in "git log ref -- path" must be
> case sensitive. Solving that is not hard: ce_path_match() and
> tree_entry_interesting() are the ones that do path matching. Those
> functions are nearly replaced in this series. I'll add
> case-insensitive support to them, so you can worry about other places.
As I recall (I'd have to examine other unsubmitted case insensitivity 
patches), merely adding case insensitivity support to ce_path_match() is 
not enough.  The cache is stored alphabetically in a case sensitive 
fashion.  That means filenames starting with 'A' are stored in a 
completely different place than filenames starting with 'a'.  Certain 
parts of the code call ce_path_match() and then walk the cache 
sequentially for possible matches.  It aborts long before hitting the 
'a' filename.

I have a patch that appears to resolve most of these issues.  For 
core.ignorecase=true, when the cache is read, it is re-sorted 
alphabetically in a case insensitive manner.  ce_path_match() still 
needs fixes, but the rest were covered by the case insensitive cache.  
'A' and 'a' are not interleaved, and the combination of sequential and 
binary(?) searches Git uses are successful.  Finally, when the cache is 
written, I re-sort the cache in a case insensitive fashion.

Hmmm... I think this was also needed for the *_name_compare() functions, 
too.

Anyway, just something to consider.

Josh
