X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 07/11] fetch-pack: use the configured transport protocol
Date: Tue, 26 May 2015 15:19:50 -0700
Message-ID: <xmqq617fj81l.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
NNTP-Posting-Date: Tue, 26 May 2015 22:19:59 +0000 (UTC)
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xKY64p3v4H1TBF+tLOQShTbdAy8uWSEgs1OTDlIFpw8=;
        b=JcDuZHmRMY6hRKe+wmpHYtKpThawHwQSFOourapM9QXxzwLQPSa14hJqmTZAiH3mS/
         Den/s681fzkLjsWyD0C2YNHHp//wDmI1DMldbNGDkXy/yqEB+wLIGXpVyIfBmCD78H2k
         SVQBn9MxEq4/xYmzCpAh9j06HLlX06Xd/zJpfAa/VrDMXWSo2joWgBknwyJmvUuXWKqz
         zsQkVPXZM9M2+Py4Kwm0xUcgziTVYTE6osQqtMNeBW/usFTKQMepk36I3AX3Y1/gS62W
         rImAS+fC7/8srvkMN23CpmsJzaroEfErj+g9Rdv+j0yiZ+AGhDtSzWAj/MzqB33gZrzs
         9VHQ==
X-Received: by 10.50.138.232 with SMTP id qt8mr32655176igb.28.1432678791882;
        Tue, 26 May 2015 15:19:51 -0700 (PDT)
In-Reply-To: <1432677675-5118-8-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 May 2015 15:01:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1YxNCX-0002FZ-Vy for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:19:58
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751295AbbEZWTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015
 18:19:53 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38009 "EHLO
 mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751011AbbEZWTw (ORCPT <rfc822;git@vger.kernel.org>); Tue, 26 May
 2015 18:19:52 -0400
Received: by igcau1 with SMTP id au1so373204igc.1 for <git@vger.kernel.org>;
 Tue, 26 May 2015 15:19:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5]) by
 mx.google.com with ESMTPSA id 17sm6317948ioq.39.2015.05.26.15.19.51
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128); Tue, 26 May 2015 15:19:51
 -0700 (PDT)
Sender: git-owner@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -175,7 +179,18 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  		if (!conn)
>  			return args.diag_url ? 0 : 1;
>  	}
> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +
> +	switch (args.version) {
> +	default:
> +	case 2:
> +		get_remote_capabilities(fd[0], NULL, 0);
> +		request_capabilities(fd[1]);
> +		break;
> +	case 1: /* fall through */
> +	case 0:
> +		get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +		break;
> +	}

