From: David Ripton <dripton@ripton.net>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 28 Sep 2010 18:22:02 -0500
Message-ID: <4CA2789A.7090306@ripton.net>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com> <7v7hi6us35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 01:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0jV5-0000Zu-7V
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 01:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab0I1XWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 19:22:07 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:60461 "EHLO
	homiemail-a47.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755321Ab0I1XWG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 19:22:06 -0400
Received: from homiemail-a47.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a47.g.dreamhost.com (Postfix) with ESMTP id D520F284065;
	Tue, 28 Sep 2010 16:22:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=ripton.net; b=
	Fkk+luIn5JOefrKfxFOJx8nts7YftqNEhis03uXJD2T00+jR+7d+S1T2ggyHkNeI
	GBvYXu+NUU2MOIOGffodJkrUUNYs+37WkQjlyoTzD7zaXwjyPiTu9eODXvERnpA5
	IbRfpTRRceJ6i82wuMmdPu1P6uI9nZD826godX7V4XE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=ripton.net; bh=mLDCtY
	MZJvYMN4xWCmlMrPt2STE=; b=4Z6j518jkauEn013pvMt3bHVvdVS/6tjvPMboK
	XsleYlKFPcxy3rgtpyxxzAY6ncPy1ExCuIMvSzYtsuYaUeIQqUwtf4ms5VoWSI/9
	S7mEVSU9XqUiT2FnykUIt1AcVPYhLgbiKneuYtRoVlgGIG3+IFgjFGVCHouMtmdo
	ReOrg=
Received: from [192.168.2.175] (pool-98-118-245-254.clppva.fios.verizon.net [98.118.245.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a47.g.dreamhost.com (Postfix) with ESMTPSA id 57119284063;
	Tue, 28 Sep 2010 16:22:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100908 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <7v7hi6us35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157495>

On 09/28/10 04:37, Junio C Hamano wrote:

>   - David's "git grep --exclude-dir D" topic should be able to internally
>     use the same negative pathspec mechanism.  At the command line level,
>     it allows (and needs to allow) only the leading prefix (which is how
>     GNU grep's --exclude-dir works), but it makes tons of sense for us to
>     allow "--exclude $pattern" from the command line, and share the
>     mechanism internally between the two.

I don't think GNU grep's --exclude-dir only allows the leading prefix. 
Here the data directory is a level below the top, but --exclude-dir=data 
effectively excludes it:

$ grep -R behemoth_green *
Binary file slugathon/util/colors.pyc matches
slugathon/util/colors.py:    "behemoth_green": (2, 129, 2),
Binary file slugathon/data/creaturedata.pyc matches
slugathon/data/creaturedata.py:"Behemoth": ("Behemoths", 8, 3, 0, 0, 
"creature", 0, 0, 18, "behemoth_green"),
slugathon/data/creaturedata.py:"Cyclops": ("Cyclopes", 9, 2, 0, 0, 
"creature", 0, 0, 28, "behemoth_green"),

grep -R --exclude-dir=data behemoth_green *
Binary file slugathon/util/colors.pyc matches
slugathon/util/colors.py:    "behemoth_green": (2, 129, 2),

IMO it's useful to allow excluding directories below the top like it 
currently does, because some projects might have a bunch of noise 
directories with the same name, and having --exclude-dir exclude them 
all would be handy.

That said, if consistency with other exclude patterns is more important 
than this use case, fine with me.

-- 
David Ripton    dripton@ripton.net
