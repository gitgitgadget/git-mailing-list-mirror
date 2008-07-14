From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 14:51:36 +0200
Message-ID: <487B4BD8.5030208@op5.se>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se> <alpine.DEB.1.00.0807141322140.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINZM-0008HL-J6
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYGNMwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYGNMwf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:52:35 -0400
Received: from mail.op5.se ([193.201.96.20]:58854 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYGNMwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:52:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7A83C24B0C55;
	Mon, 14 Jul 2008 14:52:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xh6sv9H8FFKB; Mon, 14 Jul 2008 14:52:28 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.188])
	by mail.op5.se (Postfix) with ESMTP id 534FE24B0C34;
	Mon, 14 Jul 2008 14:52:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.00.0807141322140.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88425>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 14 Jul 2008, Andreas Ericsson wrote:
> 
>> Sorry for being clueless here, but why does the older versions need
>> to be kept in-memory anyway? Aren't we applying the delta each time
>> we find one, repeatedly creating a new base-object in-memory for
>> each delta? If we aren't doing that, why do we need more than just
>> a small amount of memory just for keeping the delta?
> 
> Think of a delta chain of 49 delta objects, 1 base object.  Now 
> reconstruct all of the objects.
> 
> If you do it one by one, not storing the intermediate results, you end up 
> applying 1 delta for the first, 2 for the second (first the first, then 
> the second), and so on, in total 1 + 2 + 3 + ... + 49 = 49 * 50 / 2 = 1225 
> times.
> 
> Compare that to the 49 times when reusing the intermediate results.
> 

That's only true if you discard the result of applying D1 to DB though.
What I'm wondering is; Why isn't it done like this (pseudo-code):

while (delta = find_earlier_delta(sha1)) {
	if (is_base_object(delta)) {
		base_object = delta;
		break;
	}
	push_delta(delta, patch_stack);
}

while (pop_delta(patch_stack))
	apply_delta(base_object, delta);



where "apply_delta" replaces the base_object->blob with the delta
applied, releasing the previously used memory?

That way, you'll never use more memory than the largest ever size
of the object + 1 delta at a time and still not apply the delta
more than delta_chain_length-1 times.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
