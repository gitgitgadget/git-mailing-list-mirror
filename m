From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Thu, 12 Sep 2013 12:20:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309121214550.20709@syhkavp.arg>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com>
 <alpine.LFD.2.03.1309111224460.20709@syhkavp.arg>
 <CACsJy8B7WAz4eB88gJCWc3Z0fpSrop8f_Xex1tkmykYuSYUFUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 18:20:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK9d8-00069a-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 18:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab3ILQU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 12:20:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10596 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3ILQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 12:20:25 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT00055OTE1FVN0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Sep 2013 12:20:25 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id CAB612DA0625; Thu, 12 Sep 2013 12:20:24 -0400 (EDT)
In-reply-to: <CACsJy8B7WAz4eB88gJCWc3Z0fpSrop8f_Xex1tkmykYuSYUFUQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234660>

On Thu, 12 Sep 2013, Duy Nguyen wrote:

> On Wed, Sep 11, 2013 at 11:25 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 11 Sep 2013, Duy Nguyen wrote:
> >
> >> Nico, if you have time you may want to look into this. The result v4
> >> pack from pack-objects on git.git for me is 35MB (one branch) while
> >> packv4-create produces 30MB (v2 is 40MB). I don't know why there is
> >> such a big difference in size. I compared. Ident dict is identical.
> >> Tree dict is a bit different (some that have same hits are ordered
> >> differently). Delta chains do not differ much. Many groups of entries
> >> in the pack are displaced though. I guess I turned a wrong knob or
> >> something in pack-objects in v4 code..
> >
> > Will try to have a closer look.
> 
> Problem found. I encoded some trees as ref-delta instead of pv4-tree
> :( Something like this brings the size back to packv4-create output
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f604fa5..3d9ab0e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1490,7 +1490,8 @@ static void check_object(struct object_entry *entry)
>   * deltify other objects against, in order to avoid
>   * circular deltas.
>   */
> - entry->type = entry->in_pack_type;
> + if (pack_version < 4)
> + entry->type = entry->in_pack_type;
>   entry->delta = base_entry;
>   entry->delta_size = entry->size;
>   entry->delta_sibling = base_entry->delta_child;

Hmmm... I've folded this fix into your patch touching this area.

This code is becoming rather subtle and messy though.  We'll have to 
find a way to better abstract things.  Especially since object data 
reuse will work only for blobs and tags with packv4.  Commits and trees 
will need adjustments to their indices.


Nicolas
