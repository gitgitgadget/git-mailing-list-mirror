From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 3/9] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Mon, 16 May 2011 11:27:29 +0200
Message-ID: <201105161127.30228.johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-4-git-send-email-johan@herland.net>
 <7vsjsfmawt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 11:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLu5U-0007rv-KD
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 11:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab1EPJ1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 05:27:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42634 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab1EPJ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 05:27:33 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA002NR7LV5B70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:27:31 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E8A181EA6069_DD0EE02B	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:27:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 8DA021EA31C0_DD0EE02F	for <git@vger.kernel.org>; Mon,
 16 May 2011 09:27:30 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLA008QG7LUEV10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 11:27:30 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vsjsfmawt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173717>

On Monday 16 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Currently we refuse combining --max-pack-size with --stdout since
> > there's no way to make multiple packs when the pack is written to
> > stdout. However, we want to be able to limit the maximum size of the
> > pack created by --stdout (and abort pack-objects if we are unable to
> > meet that limit).
> > 
> > Therefore, when used together with --stdout, we reinterpret
> > --max-pack-size to indicate the maximum pack size which - if exceeded
> > - will cause pack-objects to abort with an error message.
> 
> I only gave the code a cursory look, but I think your patch does more
> than the above paragraphs say. I am not sure those extra change are
> justified.
> 
> For example,
> 
> > @@ -229,7 +229,7 @@ static unsigned long write_object(struct sha1file *f,
> > 
> >  	if (!entry->delta)
> >  		usable_delta = 0;	/* no delta */
> > -	else if (!pack_size_limit)
> > +	else if (!pack_size_limit || pack_to_stdout)
> >  	       usable_delta = 1;	/* unlimited packfile */
> 
> Why does this conditional have to change its behaviour when writing to
> the standard output?  I thought that the only thing you are doing
> "earlier we didn't allow setting size limit when writing to standard
> output, now we do", and I do not see the linkage between that objective
> and this change.

AFAICS, the intention of the above "else if" block, is to enable
usable_delta when there is no chance of a pack split happening.
To establish that a pack split cannot happen, the code checks that
pack_size_limit is disabled. Previously, pack_size_limit and
pack_to_stdout was mutually exclusive (look at the last hunk in
pack-objects.c). However, with this patch, it is possible to have
both pack_size_limit and pack_to_stdout enabled.

Crucially, though, when both are enabled, a pack split is _still_
impossible, since a pack split while pack_to_stdout is enabled, forces
pack-objects to abort altogether.

In other words, when pack_to_stdout is enabled, pack_size_limit is no
longer a good indicator of whether a pack split might happen. Instead,
pack_to_stdout being enabled is a good enough indicator in itself to
guarantee that no pack split can happen (and hence that usable_delta
should be enabled).

> > @@ -2315,9 +2318,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> > 
> >  	if (!pack_to_stdout && !pack_size_limit)
> >  		pack_size_limit = pack_size_limit_cfg;
> > -	if (pack_to_stdout && pack_size_limit)
> > -		die("--max-pack-size cannot be used to build a pack for transfer.");
> > -	if (pack_size_limit && pack_size_limit < 1024*1024) {
> > +	if (!pack_to_stdout && pack_size_limit && pack_size_limit < 1024*1024) {
> >  		warning("minimum pack size limit is 1 MiB");
> >  		pack_size_limit = 1024*1024;
> >  	}
> 
> Why is the new combination "writing to the standard output, but the
> maximum size is limited" does not have the same lower bound to pack size
> limit while on-disk packs do?

The reason for this change is purely to leave the server (receive-pack)
in control of the pack size limit. If the server for any reason does
specify a pack size limit less than 1 MiB, we do not want the client
blindly ignoring that limit, and then submitting a pack that the server
will reject.

If we _do_ want a hard lower bound on the pack size limit, we should
apply that server-side (by setting 1 MiB as the minimum allowed value
for receive.packSizeLimit). However, we will now have a problem if we
in the future decide to change this lower bound for any reason
whatsoever: We will need to change it in both receive-pack and
pack-objects, and for as long as there are new clients talking to old
servers (or vice versa if we decrease the lower bound), there will be
clients submitting packs that are then rejected by the server.

I'd rather put the server in total control of the pack size limit.

> If you have a reason to believe 1 MiB is too large for a pack size limit,
> shouldn't that logic apply equally to the on-disk case?  What does this
> change have to do with the interaction with --stdout option?

I have no opinion on the lower bound of the pack size limit in the
on-disk case.

In the above discussion, the usage of --stdout is synonymous with the
send-pack scenario (pack-objects communicating with receive-pack).
Although not true in general, it is true for this patch, since up until
now pack-objects would abort if both --stdout and --max-pack-size were
in use. Therefore, for the two changes discussed above:

 - else if (!pack_size_limit)
 + else if (!pack_size_limit || pack_to_stdout)

and

 - if (pack_size_limit && pack_size_limit < 1024*1024) {
 + if (!pack_to_stdout && pack_size_limit && pack_size_limit < 1024*1024) {

I can deduce that they only affect the current use case (the send-pack
scenario), since these changes make no (functional) difference in any
other use case (where --stdout and --max-pack-size are mutually
exclusive).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
