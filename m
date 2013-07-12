From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 22:35:36 +0200
Message-ID: <51E06898.3070303@googlemail.com>
References: <51E029B9.20108@googlemail.com> <7vfvvjjzee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxk44-0002ZH-EB
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401Ab3GLUfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:35:36 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:54799 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331Ab3GLUff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:35:35 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so8566645wes.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=JQT2J3p2PrK6WL5uDpV5LtlX5r9JSL+zw3rs+KvxncY=;
        b=b7cOlTbAFdAKDSyyVlnTuXOe6ZDg3m/YEp1V+RDqYrqbpEVzpNN6Pf1oK4OFTD3yEv
         +eECJPEP1jchCWDiKUBflbXxUVCQZGj7cV1SwhNaZ200n2ziCOySBmWR9uDsffvhD8PW
         K3bmIZJcu16+NX2EEi9wfj1nTbvWcU3FQZW0zqi+SMJzpxq8/Of08zqfuGXVUUDoSD9y
         1cipqgMqZ4feQq6igZLzh9X95TiMx0eCU5di5X/vl8cqp4bdvTbcZH+WaF4vnY9FePh8
         NNYXXOZSNSd9uTI+zvKUrTr5HK6wO8Qg8ntdQm5osG6o3amHcuqKeQbfdF5AqSI15vDV
         CUww==
X-Received: by 10.194.90.244 with SMTP id bz20mr25952106wjb.69.1373661334266;
        Fri, 12 Jul 2013 13:35:34 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm5370174wib.10.2013.07.12.13.35.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 13:35:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vfvvjjzee.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230250>

On 07/12/2013 10:28 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> 	# Adding the line to the mailmap should make life easy, so we know
>> 	# it's the same person
>> 	echo "A <A@example.org> <changed_email@example.org>" > .mailmap
> 
> While I was looking at this, I noticed this piece of code:
> 
> diff --git a/mailmap.c b/mailmap.c
> index 2a7b366..418081e 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -122,7 +122,7 @@ static char *parse_name_and_email(char *buffer, char **name,
>  	while (nend > nstart && isspace(*nend))
>  		--nend;
>  
> -	*name = (nstart < nend ? nstart : NULL);
> +	*name = (nstart <= nend ? nstart : NULL);
>  	*email = left+1;
>  	*(nend+1) = '\0';
>  	*right++ = '\0';
> 
> The function is given a buffer "A <A@example.org>...", nstart scans
> from the beginning of the buffer, skipping whitespaces (there isn't
> any, so nstart points at the buffer), while nend starts from one
> byte before the first '<' and skips whitespaces backwards and ends
> at the first non-whitespace (i.e. it hits "A" at the beginning of
> the buffer).  nstart == nend in this case for a single-letter name,
> and an off-by-one error makes it fail to pick up the name, which
> makes the entry equivalent to
> 
> 	<A@example.org> <changed_email@example.org>
> 
> without the name.  I do not think this bug affected anything you
> observed, though.
> 
>> 	git shortlog -sne
>> 		 1  A <A@example.org>
>> 		 1  A <a@example.org>
> 
> This is coming from mailmap.c::add_mapping() that downcases the
> e-mail address.
> 
> changed_email@example.org is mapped to a@example.org because of this
> downcasing, while "A <A@example.org>" does not have any entry for it
> in the .mailmap file, so it is given back as-is.  Hence we see two
> distinct entries.
> 

So do I understand it right, we're having 2 bugs in here?

One being triggered by the short name, only one character.
So if you want to debug the other bug with a longer name,
you can either use a made up name, or run
    git shortlog -sne |grep Knut
in the git repository having the mailmap file already updated.
The way the mailmap file is written, I'd assume only one line
to be found, as of now 2 lines come up
     2	Knut Franke <knut.franke@gmx.de>
     1	Knut Franke <Knut.Franke@gmx.de>

which seems to downcase the whole first email.
