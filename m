From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gc: Remove garbage .idx files from pack dir
Date: Mon, 17 Aug 2015 13:30:53 -0700
Message-ID: <xmqq37zhd5du.fsf@gitster.dls.corp.google.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<1439488973-11522-2-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:31:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRR3i-0008PG-K2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 22:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbHQUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 16:30:56 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34980 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbHQUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 16:30:55 -0400
Received: by pdob1 with SMTP id b1so3982390pdo.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IKuRlpzRmUaSJUhAUVRl+nXoIHxUHZVhn/Du7j+Cv0E=;
        b=t/FG4o/G6C4cjIW2vLNZd6kJqdUx9Q2HMkL1vELCR/KToBaJnIy55fDzcxHQL8y0lt
         XbUl8KL3D4Tg/LrBhQIzhnM/QZwqzFKUTsFipGWZE0CuWxSdxwvOkoElZ9cTKl8dCnmb
         qWevRN4Nbm9kO0TWWV2WnrWkKyJOe4nlMVoa7YVHriJyVe/4/7IdVWXWp3Z2V1KmCwJ/
         pwIPvaIKNndA7YuXhYRKIlq+Uc6iRqswnDUGJI2j0IcGVr3IW4HkEy0iDDQtkuhLbXW2
         j/aAuXg2iRHeiM5l6Df+azYV9/8Kkvs2qPdbNXJqQzu5kRvq0+J+z233mZsHSz9PeZcq
         NCHg==
X-Received: by 10.70.60.138 with SMTP id h10mr3873057pdr.163.1439843455343;
        Mon, 17 Aug 2015 13:30:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id mc1sm5146672pdb.14.2015.08.17.13.30.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 13:30:54 -0700 (PDT)
In-Reply-To: <1439488973-11522-2-git-send-email-dougk.ff7@gmail.com> (Doug
	Kelly's message of "Thu, 13 Aug 2015 13:02:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276090>

Doug Kelly <dougk.ff7@gmail.com> writes:

> +static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
> +
>  static char *pidfile;
>  
> +static void clean_pack_garbage(void)
> +{
> +	int i;
> +	for (i = 0; i < pack_garbage.nr; i++)
> +		unlink_or_warn(pack_garbage.items[i].string);
> +	string_list_clear(&pack_garbage, 0);
> +}
> +
>  static void remove_pidfile(void)
>  {
>  	if (pidfile)
> @@ -57,6 +67,12 @@ static void remove_pidfile_on_signal(int signo)
>  	raise(signo);
>  }
>  
> +static void report_pack_garbage(unsigned seen_bits, const char *path)

This change makes"pidfile management" and "pack garbage cleaning"
tangled in the result.  By inserting the definition of the variable
pack_garbage and the function clean_pack_garbage() just before this
new function, you can keep everything related to 'pack garbage
cleaning" together.
