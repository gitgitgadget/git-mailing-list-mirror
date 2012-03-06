From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC HACK] refresh_index: lstat() in inode order
Date: Tue, 06 Mar 2012 10:37:30 -0800
Message-ID: <7vipihtw2d.fsf@alter.siamese.dyndns.org>
References: <871up6cewp.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:37:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zGc-00054V-WC
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785Ab2CFShe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:37:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757774Ab2CFShd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:37:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B6651CC;
	Tue,  6 Mar 2012 13:37:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDwQuS8jy7d4AHSr69nkqTPJwlI=; b=p0jVnn
	Czz17SF4oxQb0f0jzQIheQ8CX1xC77ev1jlPu6z1BEvgfVAg7iYukyMtn7d6Y+l4
	dL12Fo5MnsD91ILPKjitZjoEkIpd1Dm3HkeNv6j3ZZX2yn0MvPzjOnWIc0vhO2nv
	Ewu8VIqBaVbRl244lUm1rnEv+epbon12gmqFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BZ9JUtnefkDa3w0YTAfVxmi6AyEc3vNh
	N0X8EqWBeYqvdhWhJjWyBKMol2LcqdDIJMYUZ728Lz1SBqfT/azv7ea0irAK5cTa
	s12mws4mkIQHXcvfQ4r9FffFzjmoi/h+OUsvIfMW9XdeZ5Y/PglI7e6OoM5eEfOm
	69JZsv1gIxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA7451CB;
	Tue,  6 Mar 2012 13:37:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 431A251CA; Tue,  6 Mar 2012
 13:37:32 -0500 (EST)
In-Reply-To: <871up6cewp.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 09:27:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F5EC49E-67BB-11E1-9892-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192372>

Thomas Rast <trast@inf.ethz.ch> writes:

> The dirty hack below uses the inode field in the index to sort the index
> entries prior to the real work of refresh_index.

I think we do something similar in fsck to touch loose object files
in clusters, and would not be surprised if you see performance boost
by running lstat(2) in clusters for the purpose of refresh_index().

Right now, preload_index() partitions the index entries by offset
and hands them out to worker threads, but it _might_ make sense to
use fewer number of threads and give them entries sorted by the inum.
