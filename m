From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 11:34:44 -0700
Message-ID: <7vljjdese3.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <20091014050851.GE31810@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910141233060.4985@pacific.mpi-cbg.de>
 <20091014153934.GA3680@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8mp-0005gB-24
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbZJNSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756763AbZJNSfk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:35:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZJNSfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:35:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ADAB581EA;
	Wed, 14 Oct 2009 14:34:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qC1RCKtVxgznVsEK0catCiGkwXA=; b=uk9yXS
	+V38JwI3c4VJabPc3PqCErwYmIceZOtvBdVd2syzN1oBxXv+BAx73R6s7OQiH81q
	ImO3gNJVP0bNp01Ob4DbNDLiKbYOOCjoLvDyOwZ4PdtmKY4wsOMQuI1uA/TDMBCy
	4I9isvVZC5du6Vfo+qHK1nNFDlAOrTZv4D6jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NHHN2WgnQrlKsNW9PgG66n6D3r06N6v+
	2MFoRoffFLou3ZZ/MNpXIkoa0BmEYLm46zoxF2M3m+IcRCvo/dUu34JmHjZ45SLQ
	tc1HdyAGSDfpAvIpaVd3npgf8GlyXPjquTBw+0OTW2zbMdwAlM3Kmpw+8jxvQ1mM
	4812nuowQh0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C82581E4;
	Wed, 14 Oct 2009 14:34:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F881581E0; Wed, 14 Oct
 2009 14:34:46 -0400 (EDT)
In-Reply-To: <20091014153934.GA3680@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 14 Oct 2009 11\:39\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42E4B74C-B8F0-11DE-BBC8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130318>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 14, 2009 at 12:33:22PM +0200, Johannes Schindelin wrote:
>
>> > > +char *get_detached_head_string(void)
>> > > +{
>> > > +	char *filename = git_path("DETACH_NAME");
>> > > +	struct stat st;
>> > > +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
>> > > +		return NULL;
>> > > +	struct strbuf buf = STRBUF_INIT;
>> > > +	strbuf_read_file(&buf, filename, st.st_size);
>> > > +	strbuf_trim(&buf);
>> > > +	return strbuf_detach(&buf, 0);
>> > > +}
>> > 
>> > Would it hurt to tuck this information into HEAD itself, as we already
>> > put arbitrary text into FETCH_HEAD?
>> 
>> AFAIR we still remember HEAD to be a symlink.
>
> I think that has been abandoned for detached HEAD (that is, if you
> support only symlinked HEAD, then you cannot detach at all). But I might
> be wrong. It has been a while since I looked at that code.

If I understand what Daniel is doing correctly, the idea is to keep this
extra information only while the HEAD is detached, no?  "HEAD itself
could be a symlink" is an irrelevant issue, isn't it?
