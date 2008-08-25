From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] mtn to git conversion script
Date: Mon, 25 Aug 2008 23:47:53 +0300
Message-ID: <94a0d4530808251347g4d6246bv7ebd5cc86294dd05@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080825163530.GJ31114@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXizj-0000Wh-SQ
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYHYUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYHYUrz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:47:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:23268 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbYHYUry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:47:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1792211rvb.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sgxRIBu50h5yBXX51naUXVHU/oRM9vjLj9CCW14wa/A=;
        b=C8WCURqi33HPWOcd300kYHh6vlmafAAxeMZKeJLa5rp8ayJX7BFSmazXIlVzqSIToj
         dWDlWau3ekh2UgX8VVUDFBHRxmm/o/002eFTeW78NYozascNCkArefM0WwCkOhfuq9FM
         1xw3/XLI0XpaH/JirNMwxTReYlsNQWk+IIK7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wfQF0PqLJkSI0nZNMyRtz02Tr4G9SOwAmdZOnaCQOBLMBNO0XXXLHEaQi/tCYGkgix
         zIDeGhDjkbQzyEcensiPVXZXNizFzA2HSFkKEh3Gq8U6vWnJ0UegIVJQh6s7eyaE6q5G
         GhMbS7ZzNxhBAKhdktkeeOqr8oLgDnp7L5DU4=
Received: by 10.141.74.18 with SMTP id b18mr2393429rvl.80.1219697273655;
        Mon, 25 Aug 2008 13:47:53 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 25 Aug 2008 13:47:53 -0700 (PDT)
In-Reply-To: <20080825163530.GJ31114@lavos.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93675>

On Mon, Aug 25, 2008 at 7:35 PM, Brian Downing <bdowning@lavos.net> wrote:
> On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras wrote:
>> I developed a script that converts a monotone repository into a git
>> one (exact clone), I want to contribute it so everybody can use it.
>>
>> This is the gist of the script:
>>
>> mtn update --revision #{@id} --reallyquiet
>> git ls-files --modified --others --exclude-standard -z | git
>> update-index --add --remove -z --stdin
>> git write-tree
>> git write-raw < /tmp/commit.txt
>> git update-ref refs/mtn/#{@id} #{@git_id}
>>
>> branches.each do |e|
>>     git update-ref refs/heads/#{e} #{@git_id}
>> end
>
> You definitely want to use fast-import, but you probably want to do
> something a lot closer to fast-export for monotone (read: use its
> automate stdio interface and avoid expensive calls).
>
> Here's a simple monotone to git converter I wrote.  You'll need the
> Monotone::AutomateStdio perl module to use it (which I think I got it
> from monotone's net.venge.monotone.contrib.lib.automate-stdio branch).
> It is very fast; it can convert the OpenEmbedded repo in something like
> 5-10 minutes on my machine.

Interesting, how many commits?

> Note that for monotone export to go fast you absolutely /must/ avoid the
> get_manifest operation.  In my converter I use the revision information
> directly.  Getting the renames right with this is a little tricky; IIRC,
> the ordering that works is:
>
> * Rename all renamed files, innermost files first, to temporary names.
> * Delete all deleted files, innermost first.
> * Rename all temporary names to permanent names, outermost first.
> * Add all new/modified files.
>
> Conveniently, all of the above can be done by directly emitting
> fast-import commands, so you don't have to keep track of trees directly.
> (With one exception, which I'll elaborate on in a different email.)

I guess I haven't stumbled upon that problem yet =/

Best regards.

-- 
Felipe Contreras
