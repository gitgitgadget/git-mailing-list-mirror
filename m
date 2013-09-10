From: Junio C Hamano <gitster@pobox.com>
Subject: breakage in revision traversal with pathspec
Date: Tue, 10 Sep 2013 10:19:20 -0700
Message-ID: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRbA-0004ZJ-JR
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3IJRT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:19:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab3IJRT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:19:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1E98406AB;
	Tue, 10 Sep 2013 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	yLbeDpHUWD2BSs+bzL1DzcjYYU=; b=rt9DWGOJL/p0rDKWq6kyigQu3gxP3iqrr
	E36ixmhALwbl26JuVvp3cbBEai9BlZYKTvVilDgtMmA6Q/LT/HU6LZI3i/PnOL0O
	dq/G9A/8ZHj730dlhCd6ksdDAFOBIZMpj5uW9ybzWMR5NhyEzXEJlT7f5CrtkkDW
	SLt/aUaaMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=vyQH4KGq8Bx+4X5dVlMWtmX9ZxFgGBv3IswEIgQZNvHlBgRvWZqYkG9t
	w0lscHYqP63O8Nd3dvikqtDesPzyzh6FoGqNhQHOwW4ohFBOOyA0RBwqlXn3GT8D
	ww81nzXT3nVvB5RjslmjHytbeie9lwydT7h/wFZEnawXlPl4EoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79D664069F;
	Tue, 10 Sep 2013 17:19:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6587C40691;
	Tue, 10 Sep 2013 17:19:22 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 233FE922-1A3D-11E3-9E32-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234462>

I am grumpy X-<.

It appears that we introduced a large breakage during 1.8.4 cycle to
the revision traversal machinery and made pathspec-limited "git log"
pretty much useless.

This command

    $ git log v1.8.3.1..v1.8.4 -- git-cvsserver.perl

reports that a merge 766f0f8ef7 (which did not touch the specified
path at all) touches it.

Bisecting points at d0af663e (revision.c: Make --full-history
consider more merges, 2013-05-16).
