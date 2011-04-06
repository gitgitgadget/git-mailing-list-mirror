From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: "git stash" changes owners and permissions
Date: Wed, 06 Apr 2011 14:48:08 -0700
Message-ID: <7voc4jgig7.fsf@alter.siamese.dyndns.org>
References: <878vvnfp60.fsf@kiva6.ethz.ch> <20110406184938.GE1220@elie>
 <20110406200640.GF12557@sym.noone.org> <20110406205212.GC1922@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Axel Beckert <abe@debian.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:48:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aae-0002ds-Qf
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357Ab1DFVs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:48:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab1DFVsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:48:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9F4755F2;
	Wed,  6 Apr 2011 17:50:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJNTYWjIJddkLC2NiA3asmmAXtA=; b=xYv4MV
	hsnfvk6TNzKDmto/7O3lYneHpB/TIqQSPU7mQq5/shpaOYej2YEsfymmiONqwkjD
	UfgEJMSkYip0JagegCLJXMul2bc1ELPsCXOIr/ZfqmFw/jj55qb8WBaSq1OKiz7v
	BiDZfEp7MDUr0EVHgyGmliPE4qJPf2gY0gKXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SaESxXCjwFk544Gw+ZRT3XZeTYIk7K99
	5gHMw1IgmAZ/Q6iMQTXlMt4knPAzH7aHnLmMHBPMJvcVmZvRYiwlVAt9OC+Gxv5w
	52+DppQBrGZJ6oOKyF6TVkAQ84K4q3B0s4uuubuGtAIlIcuCoFgO3gQvCOrkENN0
	8jcA7iL6TsE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A40455EF;
	Wed,  6 Apr 2011 17:50:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6669A55E8; Wed,  6 Apr 2011
 17:50:04 -0400 (EDT)
In-Reply-To: <20110406205212.GC1922@elie> (Jonathan Nieder's message of "Wed,
 6 Apr 2011 15:52:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D83E9ABA-6097-11E0-83B6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171022>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...
> As mentioned before, I don't advise using git to deploy changed files.
> It will change them in the wrong order and creates windows when they're
> not present.  Perhaps a procedure like the following can work?
>
> 	cd /root; (umask 077 && mkdir tmp); cd tmp
> 	git clone /etc/interesting-subdir
>...
> 	# deploy.
> 	rsync -a --exclude='.git' /root/tmp/interesting-subdir/ .
> 	git reset jrn/proposed
> 	git diff;	# should show no changes.


How does this "rsync" solve "the wrong order" and "creates windows"
problems?  It will update the paths in the order rsync happens to discover
and there is a wondow between the time the first path is updated and the
whole directory gets finally in sync.

If you truly want an atomicity, you can make /etc/interesting-subdir a
symbolic link that points to either interesting-subdir-{0,1}, do the above
procedure of yours against interesting-subdir-0 (or 1) that is currently
not pointed by the symbolic link, and when everything in that one is Ok,
atomically switch the symbolic link to point at it.
