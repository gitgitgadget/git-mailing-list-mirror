From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Thu, 05 Jul 2012 23:28:48 -0700
Message-ID: <7v7guhpfmn.fsf@alter.siamese.dyndns.org>
References: <1341409220-27954-1-git-send-email-pw@padd.com>
 <1341409220-27954-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 08:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn22D-0006ar-FM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 08:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554Ab2GFG2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 02:28:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab2GFG2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 02:28:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66BE18E1B;
	Fri,  6 Jul 2012 02:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wLUlM/0KayMrs6LZAoGcIwtaDgE=; b=Rl0S5d
	sIQCuBbKIVAXUHSkY8MydgGsTHnTG9MdzZPD1I3Fwzju0hlvjNm7R0/mTpy5eoCa
	0iLhUk8CE66dikysfK6ENc5r54qQFmSZZ6omahfMRoTG0wsi8NPgEGwmZLr8Q+dw
	25o/MqFdvjwTh2+2gtPDts7KQhRa2nUcsnJqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQ2AVhiPMPGI01hoAMJ00nksdBoICPr1
	TFl/btFtV20jJ8COpDhzYY5fyAicUt2K3OiHjQT6CmQmRYpw9y1LRsBZZfMfCSe5
	YF8giMLoYYXEeFP80+6Ido2ChmZeKEwq4W1r2RnLC/YWIswJy9gKZON0JznZMK2a
	157mAvpNL8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E69A8E19;
	Fri,  6 Jul 2012 02:28:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E09128E18; Fri,  6 Jul 2012
 02:28:49 -0400 (EDT)
In-Reply-To: <1341409220-27954-3-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Wed, 4 Jul 2012 09:40:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D936685E-C733-11E1-A804-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201085>

Pete Wyckoff <pw@padd.com> writes:

> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> index 84fffb3..8be74b6 100755
> --- a/t/t9814-git-p4-rename.sh
> +++ b/t/t9814-git-p4-rename.sh
> @@ -77,16 +77,16 @@ test_expect_success 'detect renames' '
>  		git commit -a -m "Rename file1 to file4" &&
>  		git diff-tree -r -M HEAD &&
>  		git p4 submit &&
> -		p4 filelog //depot/file4 &&
> -		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
> +		p4 filelog //depot/file4 | tee filelog &&
> +		! grep -q " from //depot" filelog &&

I am not a huge fan of using "tee" in our test scripts, especially
as it means piping output of another command whose output (and
presumably the behaviour) we care about, hiding its exit status.

Fixing the incorrect use of piping to "test_must_fail grep" is a
good change, but is there anything wrong to do the above like this?

	p4 filelog //depot/file4 >filelog &&
	! grep -q " from //depot" filelog &&
