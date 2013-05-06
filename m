From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 10:17:41 -0700
Message-ID: <7v8v3srpsa.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<20130506162008.GB7992@sigill.intra.peff.net>
	<7vli7srrva.fsf@alter.siamese.dyndns.org>
	<20130506164046.GA20257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 19:17:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZP2r-00018B-SO
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab3EFRRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:17:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847Ab3EFRRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:17:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E070F1C8D2;
	Mon,  6 May 2013 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SocYREeQ7u9RGhbbq11aJzjcJVk=; b=rYSbE1
	SpLLjRGTGQOqB9kpwrSW3W8qyJLNO0FY3N9b6nyoK8OecachEy0GHaGd+BNCzfsQ
	fw2naPyACOQ0XWGpLFUVvPEmMpS6d4KX9aUkgRTPD8JJPaZyFTV1+MLEd++OzpN6
	fkVDEJfT/LqU9y8XfrERdOYYvCCcOv8KEW00A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eJ+aJMCgrESLugXz2DNNbiGhd0ADIlzn
	Rw9lR6ewAOU0NRjiAddqiScJYkjsxKJ+3UdKN8WC2COR6ZiyFQg7b6CfFoA6Su/0
	yAdwsvcqJumDKHgSNpFEnp36Jx7LiUzEBOZK2SVEPi03aoUasyJT4PmwjYlSywCi
	IOs25/PPlYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3B3F1C8CF;
	Mon,  6 May 2013 17:17:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48F0A1C8CA;
	Mon,  6 May 2013 17:17:43 +0000 (UTC)
In-Reply-To: <20130506164046.GA20257@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 May 2013 12:40:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCE400F6-B670-11E2-9257-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223475>

Jeff King <peff@peff.net> writes:

> So yes, I think this is an obviously correct optimization. Thanks for
> clarifying, and sorry to be so slow.

No need to be sorry.  It just shows that the log message could have
been more helpful.

Here is what I tentatively queued.

commit 83582e91d22c66413b291d4d6d45bbeafddc2af9
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun May 5 17:38:53 2013 -0500

    fast-export: do not parse non-commit objects while reading marks file
    
    We read from the marks file and keep only marked commits, but in
    order to find the type of object, we are parsing the whole thing,
    which is slow, specially in big repositories with lots of big files.
    
    There's no need for that, we can query the object information with
    sha1_object_info().
    
    Before this, loading the objects of a fresh emacs import, with 260598
    blobs took 14 minutes, after this patch, it takes 3 seconds.
    
    This is the way fast-import does it. Also die if the object is not
    found (like fast-import).
    
    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
