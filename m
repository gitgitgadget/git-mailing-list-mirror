From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 19:43:42 -0800
Message-ID: <xmqqfuwzykr5.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
	<20160210210115.GA10155@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 04:44:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTiAu-00049f-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 04:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbcBKDnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 22:43:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbcBKDnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 22:43:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B50384401B;
	Wed, 10 Feb 2016 22:43:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t8jWuz0RnTy/0QR/hSVC6mZ9jbY=; b=XNyiVi
	1e/LiWFEJKw5mdqjuCjPq1bPuUSll3xkYhKTTcdCS3QLgmDQ1BnpmBiKaD04dXoN
	9Uol5jESJ31hXVQGpoUr/qdBoDHo9jYJeLtX++lnHtajuYKycWc0cO8TTZ6+yhh9
	/MDxoLnKyYzbejDedNIN1VNuziBwmNSL/Ikuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTqn/fgmgaa8XpdAgMr9vowZMmW4btOH
	smWvGTVbSM4mkiMGc6ELyruW5tg+WSF+LBmgmu3c+sf9Vt2EKmd3KU7/+oguLzJ/
	u1vor09izcgVj7xrHI8LKXOSg7WD4mA9H9LzvXHAtMpA0GqqxU6A+Ui/tPpt1Lwo
	ut/M+CsZHNg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9894344019;
	Wed, 10 Feb 2016 22:43:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A07844018;
	Wed, 10 Feb 2016 22:43:43 -0500 (EST)
In-Reply-To: <20160210210115.GA10155@google.com> (Jonathan Nieder's message of
	"Wed, 10 Feb 2016 13:01:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A60F671E-D071-11E5-B24E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285945>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I really like this design.  I'm tempted to implement it (since it
> lacks a bunch of the downsides of clone.bundle).

Just to see people are not stepping on each others toe, implementing
slightly different components in parallel based on the same theme to
solve the same problem, it may be beneficial to have a list of a bit
more detailed breakdown of the necessary parts.

I think possible small first steps include:

 * A new "--split-header" option to "git bundle" that allows the
   command to write out two files;

 * An update to the "bundle" transport so that it understand the new
   split bundle format (i.e. when you have base.bndl that refers to
   pack-deadbeef.pack, you can still say "git clone base.bndl" and
   "git ls-remote base.bndl");

 * A new "--bundle-header" option to "git index-pack", which makes
   it to write out the bundle header file that references the
   resulting packfile in addition to the pack .idx file (this should
   also be able to "fix" thin pack, and also by keeping track of the
   actual "foreign" objects not just number of them, compute and
   record the list of prerequisite objects in the resulting bundle
   header file).

Am I on the right track?  Assuming I am, anything I missed?
