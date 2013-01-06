From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 6 Jan 2013 15:27:16 +0000
Message-ID: <20130106152716.GB2396@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
 <7v623cqd39.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 16:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trs8U-0005Ty-LK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 16:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab3AFP1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 10:27:19 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45367 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3AFP1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 10:27:18 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 3A13D2E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 15:27:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v623cqd39.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212809>

On Fri, Jan 04, 2013 at 11:54:34PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Adam Spiers <git@adamspiers.org> writes:
> >
> >> diff --git a/builtin/clean.c b/builtin/clean.c
> >> index 0c7b3d0..bd18b88 100644
> >> --- a/builtin/clean.c
> >> +++ b/builtin/clean.c
> >> @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >>  	if (!ignored)
> >>  		setup_standard_excludes(&dir);
> >>  
> >> +	add_exclude_list(&dir, EXC_CMDL);
> >>  	for (i = 0; i < exclude_list.nr; i++)
> >>  		add_exclude(exclude_list.items[i].string, "", 0,
> >> -			    &dir.exclude_list[EXC_CMDL]);
> >> +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
> >
> > This looks somewhat ugly for two reasons.
> >
> >  * The abstraction add_exclude() offers to its callers is just to
> >    let them add one pattern to the list of patterns for the kind
> >    (here, EXC_CMDL); why should they care about .ary[0] part?  Are
> >    there cases any sane caller (not the implementation of the
> >    exclude_list_group machinery e.g. add_excludes_from_... function)
> >    may want to call it with .ary[1]?  I do not think of any.
> >    Shouldn't the public API function add_exclude() take a pointer to
> >    the list group itself?
> >
> >  * When naming an array of things, we tend to prefer naming it
> >
> >      type thing[count]
> >
> >    so that the second element can be called "thing[2]" and not
> >    "things[2]".  dir.exclude_list_group[EXC_CMDL] reads better.
> 
> Also, "ary[]" is a bad name, even as an implementation detail, for
> two reasons: it is naming it after its type (being an "array") not
> after what it is (if it holds the patterns from the same information
> source, e.g. file, togeter, "src" might be a better name), and it
> uses rather unusual abbreviation (I haven't seen "array" shortened
> to "ary" anywhere else).

OK, well in that case Documentation/technical/api-allocation-growing.txt
needs to be fixed, because I copied it from that.  I would never normally
shorten "array" to "ary" either, but I did it in an attempt to conform
to the stated guidelines.
