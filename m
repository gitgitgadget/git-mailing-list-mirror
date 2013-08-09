From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Fri, 9 Aug 2013 20:13:09 +0700
Message-ID: <CACsJy8A5VkyMcvtqu2J0COh5+pqKTkmCstLzDpPS5_0T+XFtsA@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org> <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
 <7v1u64az18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 15:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mVn-00050j-F2
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 15:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab3HINNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 09:13:42 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39785 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130Ab3HINNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 09:13:39 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so6472928obc.27
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2GgbAApu4AzIL6plIRaReCOsPNQjVwKepEQszu2lEjo=;
        b=LYVIjXVhWJFcvy7xxMNKfhODb+Tz6TnYRZolFOakGriQnuHRoza6Wd8QZZ/UvsAtCY
         eT3a85o7GXcYDKCeUV6x3Ro51OnyPnz8SpF+6bmcnJN51f64V2UoXgCx5GkdYH1XYuHY
         l4IcfcsECPStIodyWrxKvyj/JcaxfEVB7lHcopWKVJvtiTiCc391dNMOXcqbU9pzepUM
         UOgCLJa3KRFByjNVB/SA3cAkD8uLsrLEux2EXrkRFacoVJQl8jmnadIsQ6S1tsU1Wggp
         Do1vFJmYXXql/kZYgyoovpPszrfV2BASx1yhcRsSbQWskERY91iBSRRwrtVUEdUM6R4U
         vHSQ==
X-Received: by 10.60.34.4 with SMTP id v4mr461378oei.101.1376054019059; Fri,
 09 Aug 2013 06:13:39 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 9 Aug 2013 06:13:09 -0700 (PDT)
In-Reply-To: <7v1u64az18.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231980>

On Fri, Aug 9, 2013 at 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I fail to see the point here. There are two different things: what we
>> want to send, and what we can make deltas against. Shallow boundary
>> affects the former. What the recipient has affects latter. What is the
>> twist about?
>
> do_rev_list() --> mark_edges_uninteresting() --> show_edge() callchain
> that eventually does this:
>
> static void show_edge(struct commit *commit)
> {
>         fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
> }
>
> was what I had in mind.

Now I see. Thanks.

mark_edges_uninteresting() actually calls
mark_edge_parents_uninteresting(), which calls show_edge(). The middle
function is important because after calculating new depth, upload-pack
calls register_shallow() for all both old and new shallow roots and
those commits will have their 'parents' pointer set to NULL, which
renders mark_edge_parents_uninteresting() no-op. So show_edge() is
never called on shallow points' parents.

>> As for considering objects before shallow boundary uninteresting, I
>> have a plan for it: kill upload-pack.c:do_rev_list(). The function is
>> created to make a cut at shallow boundary,...
>
> Hmph, that function is not primarily about shallow boundary but does
> all packing in general.
>
> The edge hinting in there is for thin transfer where the sender
> sends deltas against base objects that are known to be present in
> the receiving repository, without sending the base objects.

OK but edge hinting is the same in pack-objects.c:get_object_list() so
the plan might still work, right? I still need to study about
extra_edge_obj in upload-pack.c though. That's something knowledge
that pack-objects won't have.
-- 
Duy
