From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 17:49:53 +0100
Message-ID: <237967ef0810260949q37e474e2y51a7ac6754dc0554@mail.gmail.com>
References: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
	 <7vljwb5o4p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 17:52:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku8qh-0002lL-Mg
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 17:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYJZQt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYJZQtz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 12:49:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:3212 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbYJZQtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 12:49:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so539185nfc.21
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=52JH9tWgxykU2RzDTRn3oWqbI6hQhgaMVjv2RbY5hTg=;
        b=dhajVZbmpFO/xtZOXS9X9VDa6nFmOFHssnJbMBZWjl8xk3jwwY8X0DFqFS2a5C1scM
         MZFkXL8gIwGDXlVlTjRnP74V/9EtQcOOedweniNk7WOjj1jsCtxRS3Az3r2Wgcz7/3C5
         WidFxzD/JN3KsRL3uEVdv/knTh4k95zGoPc7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wxLGzQ506d2wUfDvurvbi8HWCk6fQgQ3YVATOukHFc1UUX3A58YjnjRzi1OD7WEdN8
         8Chk/tgFhBSht1ZsH08JpVxx5BRS5yAGRsx/t2QEgQLlKMc9xkkgoxRf4GbsN6zNCCvQ
         kSsOqtruQ7mo04nhQZ2uWxT42aqY++EHSxZX4=
Received: by 10.210.39.2 with SMTP id m2mr5333470ebm.191.1225039793327;
        Sun, 26 Oct 2008 09:49:53 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Sun, 26 Oct 2008 09:49:53 -0700 (PDT)
In-Reply-To: <7vljwb5o4p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99173>

2008/10/26 Junio C Hamano <gitster@pobox.com>:
> "Mikael Magnusson" <mikachu@gmail.com> writes:
>
>> % mkdir 1; cd 1
>> % echo > a; git add a; git commit -m a
>> % cd ..
>> % git clone -s 1 2
>> % git push . master:master
>> fatal: Could not switch to
>> '/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
>> fatal: The remote end hung up unexpectedly
>
> I think I see a bug in foreach_alt_odb() to add_refs_from_alternate()
> callchain, but I cannot explain why the contents of $PATH leaks to the
> error message.
>
> Can you try this patch?

Yeah this fixes the issue for me. If I add this
static int add_refs_from_alternate(struct alternate_object_database
*e, void *unused)
{
+	fprintf(stderr, "add: %s\n", e->base);
	char *other = xstrdup(make_absolute_path(e->base));
	size_t len = strlen(other);

and

	prepare_alt_odb();
	for (ent = alt_odb_list; ent; ent = ent->next) {
		fprintf(stderr, "for: %s\n", ent->name);
		if (fn(ent, cb))
			return;

then i get
for: in//usr/qt/3/bin:/usr/games/bin:/usr/loca
add: /tmp/a/1/.git/objects/in//usr/qt/3/bin:/usr/games/bin:/usr/loca
fatal: Could not switch to
'/tmp/a/1/.git/objects/in//usr/qt/3/bin:/usr/games/bin:/usr'
fatal: The remote end hung up unexpectedly

-- 
Mikael Magnusson
