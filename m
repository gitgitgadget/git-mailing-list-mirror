From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] msvc: opendir: allocate enough memory
Date: Fri, 26 Nov 2010 10:34:48 -0800
Message-ID: <7vfwuoq6gn.fsf@alter.siamese.dyndns.org>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
 <1290537509-360-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	jrnieder@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 19:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM38Z-0002a4-0H
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0KZSfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 13:35:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0KZSfC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:35:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 959C4200D;
	Fri, 26 Nov 2010 13:35:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6rqdhhrgMo6xVzHZ4Nbl1gHDJ1o=; b=HATsPsaAxbpC4osxM4+2yjj
	1pJdWeHKIlhgPXFZzqCKRq3lJMDhd7NPii69NQM8TO5J/sd8ir8ReLtvhHMv3d2s
	K3EghB0l5byMXiIjtyqnMCQ9a7rH3TyxIESeoQPBOKfcrLFk4XVM2tj1//YXQa0n
	P7vLiWrnNnzRBjIybi6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LU0WbC74ttKDYfhRRvkreidFud7TBJzPNg2fn69cRa5Q63aL3
	6LbOO3hH1F2T8dQIBTPJFne0yNyIkyS8GidKFolreGtsn3eJo0muWP1iZKduGB8t
	GMQzsyB2d9ciyMnI+eTPF8Cx9ZQP9ImvqCBOtOJi4ixWpLEmlFjAEOG9zk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 465372008;
	Fri, 26 Nov 2010 13:35:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6B9502007; Fri, 26 Nov 2010
 13:35:05 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E765CBE4-F98B-11DF-A13D-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162272>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>  DIR *opendir(const char *name)
>  {
> -	int len;
> +	int len = strlen(name);
>  	DIR *p;
> -	p = malloc(sizeof(DIR));
> +	p = malloc(sizeof(DIR) + len + 2);
>  	if (!p)
>  		return NULL;
>  
> -	memset(p, 0, sizeof(DIR));
> -	strncpy(p->dd_name, name, PATH_MAX);
> -	len = strlen(p->dd_name);
> +	memset(p, 0, sizeof(DIR) + len + 2);
> +	strcpy(p->dd_name, name);

I'd queue this anyway, but I think you do not have to memset() that many
bytes.  It should be enough to clear sizeof(DIR) here; you have to assign
NUL p->dd_name[len+2] though.

>  	p->dd_name[len] = '/';
>  	p->dd_name[len+1] = '*';
>  
> -- 
> 1.7.3.2.493.gc8738
