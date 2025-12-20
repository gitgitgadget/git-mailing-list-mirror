Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDB2288F7
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766236504; cv=none; b=tLVczejTMBZ32UCT/vxoIz0SoICpxn63bTC4PtnWhRN4ATk52Xx0Q4NukA5983B3KOyCzcO9RDS3ajdDYAJgIdRYcsSmxO966Nlj7gVudran+oF30qmaeRTOjs/KPrlpfDMGEO3DZJErrTuWxNLSlXPn2oODNG4iUlDW04LPGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766236504; c=relaxed/simple;
	bh=BEbQs7PV2Y4U2vp6dSpXHomhmvLxrsX5Wvvek/PVGWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcZxQUaXXHaMHeBDZs/sP+ZxMLZipwvVBEg1mFusXRLA0cg8n91bVxyzgqnLmpw4NL+bHeSj7jo/z3scGUpcg2GiOwzxeiCngqchgpKTa26ZxUhtGXyK+uzu5tOf6K1pM66lF0iZJP2twwnmwAiT4S26zqAgu7idDD3+sdOcXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dYPyL70m9zRpKJ;
	Sat, 20 Dec 2025 14:14:50 +0100 (CET)
Message-ID: <a8cc6a07-9b63-46e8-936a-4aefeb0a1311@kdbg.org>
Date: Sat, 20 Dec 2025 14:14:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: add --no-indicators option
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: collin.funk1@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 phillip.wood@dunelm.org.uk, phillip.wood123@gmail.com
References: <f141e335-9729-4f09-86b2-12a39f24837a@gmail.com>
 <20251219145037.17880-1-haraldnordgren@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20251219145037.17880-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.12.25 um 15:50 schrieb Harald Nordgren:
> Hi Collin!
> 
> The use case for me is when working on a feature and digging through my own
> commits to recover a code block that I previously threw away. Then I dont't
> want to do 'git restore -p' and go through all the changes in that file.
> 
> I just want to quickly pick out the thing I need, that could be e.g. this
> snippet
> 
> ```
>             top={
>               spcGoalMarkerPositionStaticProps.y -
>               ARROW_SIZE / 2 +
>               ARROW_OUTWARD_OFFSET * Math.sin(arrowAngleRadians)
>             }
>             left={
>               spcGoalMarkerPositionStaticProps.x -
>               ARROW_SIZE / 2 +
>               ARROW_OUTWARD_OFFSET * Math.cos(arrowAngleRadians)
>             }
> ```
> 
> from the full diff below:
> 
> ```
> --- a/src/ui/components/SatietyIndicator.tsx
> +++ b/src/ui/components/SatietyIndicator.tsx
> 
>    const spcGoalCompletionOuterGAnimProps = useAnimatedProps(() => {
>      return {
> -      opacity: satietyGoalScore
> +      opacity: shouldShowGoalMarker
>          ? interpolate(spcGoalMarkerOpacitySV.value, [0, 1], [1, 0])
>          : 0,
>      }
> @@ -364,7 +372,7 @@ export const SatietyIndicator: FC<Props> = ({
> 
>      const centerAdjustment = -(CHECKMARK_SIZE * scale) / 2
> 
> -    return satietyGoalScore
> +    return shouldShowGoalMarker
>        ? {
>            transform: [
>              {scale: scale},
> @@ -383,11 +391,19 @@ export const SatietyIndicator: FC<Props> = ({
>          {shouldShowReachHere && (
>            <AnimatedBox
>              position={'absolute'}
> -            top={spcGoalMarkerPositionStaticProps.y - 18}
> -            left={spcGoalMarkerPositionStaticProps.x - 9}
> +            top={
> +              spcGoalMarkerPositionStaticProps.y -
> +              ARROW_SIZE / 2 +
> +              ARROW_OUTWARD_OFFSET * Math.sin(arrowAngleRadians)
> +            }
> +            left={
> +              spcGoalMarkerPositionStaticProps.x -
> +              ARROW_SIZE / 2 +
> +              ARROW_OUTWARD_OFFSET * Math.cos(arrowAngleRadians)
> +            }
>              style={arrowBounceStyle}>
>              <PointerArrow
> -              size={18}
> +              size={ARROW_SIZE}
>                color={'black'}
>                angle={270 + arrowTiltDegrees}
>              />
> ```
> 
> I do this already, it just has the extra step of having to go through
> manually and remove +/- characters. Since already have the red and green
> colors to judge me, +/- doesn't help anything.
> 
> I would also like to add this to 'git show'
I think you are looking for `git difftool`. For me, on Linux it uses
meld, on Windows, I've configured it to use WinMerge. With both it is
very easy to move hunks or even just individual lines between versions.

-- Hannes

