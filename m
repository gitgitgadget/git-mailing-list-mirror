From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 5/8] Support taking over transports
Date: Wed, 9 Dec 2009 17:17:18 +0200
Message-ID: <20091209151718.GE15673@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-6-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vljhd597h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:17:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOID-0006Z4-4p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZLIPRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbZLIPRQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:17:16 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51285 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbZLIPRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:17:15 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 06F30EF62E;
	Wed,  9 Dec 2009 17:17:21 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06BA1E92AE; Wed, 09 Dec 2009 17:17:20 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id C7EB841BE3;
	Wed,  9 Dec 2009 17:17:18 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vljhd597h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134978>

On Tue, Dec 08, 2009 at 03:37:06PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> Will we ever have another 'xxxoptions' field in this structure that is not
> so git-ish?  'gitoptions' somehow doesn't feel right, unless you plan to
> later add scm specific options like 'hgoptions', 'bzroptions' in this
> field you need to distinguish "git" one from them.
> 
> I know you needed to name the new field to store the transport option
> under a different name from the existing 'option' field, but for that
> purpose, 'transport_options' might be a more appropriate name.

Changed.
 
> > @@ -109,9 +111,19 @@ static struct child_process *get_helper(struct transport *transport)
> >  		die("Unable to run helper: git %s", helper->argv[0]);
> >  	data->helper = helper;
> >  
> > +	/*
> > +	 * Open the output as FILE* so strbuf_getline() can be used.
> > +	 * Do this with duped fd because fclose() will close the fd,
> > +	 * and stuff like taking over will require the fd to remain.
> > +	 *
> > +	 */
> > +	duped = dup(helper->out);
> > +	if (duped < 0)
> > +		die_errno("Can't dup helper output fd");
> > +	data->out = xfdopen(duped, "r");
> > +
> 
> Neat hack (the kind I often love), but it makes something deep inside me
> cringe.  This looks fragile and possibly wrong.
> 
> Who guarantees that reading from the (FILE *)data->out by strbuf_getline()
> that eventually calls into fgetc() does not cause more data be read in the
> buffer assiciated with the (FILE *) than we will consume?  The other FILE*
> you will make out of helper->out won't be able to read what data->out has
> already slurped in to its stdio buffer.

Causality impiles this can happen only if buffered version gets its buffer
filled after sending connect command. And looking at stdio operations that
can occur after sending the command:

- fprintfs on stderr (debug mode only).
- fgetc()s on unbuffered version.

-Ilari
