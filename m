From: Junio C Hamano <gitster@pobox.com>
Subject: Re: arbitrary memory allocation
Date: Mon, 30 Nov 2015 16:17:08 -0800
Message-ID: <xmqqmvtv6n0b.fsf@gitster.mtv.corp.google.com>
References: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: ytrezq@sdf-eu.org
X-From: git-owner@vger.kernel.org Tue Dec 01 01:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3YdB-0002ub-7D
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 01:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbbLAARM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 19:17:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751710AbbLAARL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 19:17:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 413D930E9A;
	Mon, 30 Nov 2015 19:17:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h+bxK427DELStuN8hfwZ4mljfgs=; b=ZVyCTN
	Ivn21h7OONEdHpLUf3HQWf9D/LcOy9BE2Iz9VPKxOm9nTMm3fusBbpX3W4kCe4tG
	oz1dhrjyT+OzflM4kKEI6bCWJXD6NMGVxOdJp3GqBTB/G8gzLVPB85FN0kX3Q4SV
	JyIj2IecRIU+aUBTieucvsrcKriOHt0kEIKPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vof7O6U3j7eNgx4o4MoZcHKH5V/wlojK
	BOiuflOQ4AE+1DGB/LWqFH3OoU3+accth6qO1otug476RB/JbgtxX5INFx/DnSy3
	6dVnY2y4W/T0dF1fssDgG+md7UZpw2aHjtjAYbgXa/4dmQPv0zc4Qh6O8m8DIiS/
	YOLGmXjagtw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BED930E99;
	Mon, 30 Nov 2015 19:17:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91FC430E98;
	Mon, 30 Nov 2015 19:17:09 -0500 (EST)
In-Reply-To: <1a012fc79a55cae8b948b28d1259be0c.squirrel@sdfeu.org>
	(ytrezq@sdf-eu.org's message of "Thu, 26 Nov 2015 05:06:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DCA7064A-97C0-11E5-A4F7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281826>

ytrezq@sdf-eu.org writes:

> line_list="0032want "+obj[1][:40]+'\n'
> while len(line_list)<65430: # Get the ideal tcp packet size for fastest bandwidth (64Ko)
> 	for i in obj:
> 		if (i==obj[0]) or (i==obj[1]) or ("pull" in i):
> 			continue
> 		line_list+="0032want "+i[:40]+'\n'
> 		if len(line_list)>65480:
> 			break
> ...
> line_list_len=line_list.count('\n')*56 # Line lengths of the pkt-line format won t fill the ram, so remove them from the size counter
> count=line_list_len
> while True:
> 	sys.stdout.flush()
> 	sockobj.send(line_list) # for each line, the git-send-pack process allocate append a member to a struct objects array
> 	print("\r%.2f Mo of ram filled" % float(count/float(1048576))),
> 	count+=line_list_len

This seems to be attempting to throw "want XXXXXXXX" that are
outside the original server-side advertisement over and over.  Even
though the set of distinct "want" lines you can throw at the server
is bounded by the server-side advertisement (i.e. usually you won't
be able to throw an object name that does not appear at the tip), by
repeating the requests, you seem to be hoping that you can exhaust
the object_array() used in upload-pack.c::receive_needs().

But does that attack actually work?  After seeing these "want"
lines, the object name read from there goes through this code:

		o = parse_object(sha1_buf);
		if (!o)
			die("git upload-pack: not our ref %s",
			    sha1_to_hex(sha1_buf));
		if (!(o->flags & WANTED)) {
			o->flags |= WANTED;
			if (!is_our_ref(o))
				has_non_tip = 1;
			add_object_array(o, NULL, &want_obj);
		}

So it appears to me that the requests the code makes in the second
and subsequent iterations of "while True:" loop would merely be an
expensive no-op, without bloating memory footprint.

It does waste CPU cycle and network socket, though.
